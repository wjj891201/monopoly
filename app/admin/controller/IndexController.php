<?php


declare(strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\exception\RespException;
use Carbon\Carbon;
use think\facade\Cache;
use think\facade\Db;
use think\facade\View;

class IndexController extends BaseController
{
    public function index()
    {
        $admin = get_login_admin();
        if (get_cache('menu' . $admin['id'])) {
            $list = get_cache('menu' . $admin['id']);
        } else {
            $adminGroup = Db::name('admin_role_access')->where(['uid' => get_login_admin('id')])->column('role_id');
            $adminMenu = Db::name('admin_role')->where('id', 'in', $adminGroup)->column('rules');
            $adminMenus = [];
            foreach ($adminMenu as $k => $v) {
                $v = explode(',', $v);
                $adminMenus = array_merge($adminMenus, $v);
            }
            $menu = Db::name('admin_menu')
                ->where(['menu' => 1, 'status' => 1])
                ->where('id', 'in', $adminMenus)->order('sort_order asc')->select()->toArray();
            $list = list_to_tree($menu);
            Cache::tag('adminMenu')->set('menu' . $admin['id'], $list);
        }
        $theme = Db::name('admin')->where('id', $admin['id'])->value('theme');
        View::assign('theme', $theme);
        View::assign('menu', $list);
        return View();
    }

    public function main()
    {
        $todayStart = Carbon::now()->startOfDay()->toDateTimeString();
        $todayEnd = Carbon::now()->endOfDay()->toDateTimeString();
        $weekStart = Carbon::now()->startOfWeek()->toDateTimeString();
        $weekEnd = Carbon::now()->endOfWeek()->toDateTimeString();
        $monthStart = Carbon::now()->startOfMonth()->toDateTimeString();
        $monthEnd = Carbon::now()->endOfMonth()->toDateTimeString();
        $totalStart = '0000-00-00 00:00:00';
        $totalEnd = Carbon::now()->toDateTimeString();

        $dateArr = [
            'today' => ['start' => $todayStart, 'end' => $todayEnd],
            'week' => ['start' => $weekStart, 'end' => $weekEnd],
            'month' => ['start' => $monthStart, 'end' => $monthEnd],
            'total' => ['start' => $totalStart, 'end' => $totalEnd],
        ];


        $memberCount = [];
        $orderCount = [];
        $walletCount = [];
        $storeCount = [];
        foreach ($dateArr as $key => $value) {
            $memberCount[$key] = Db::name('member')->where([
                ['created_at', '>=', $value['start']],
                ['created_at', '<=', $value['end']]
            ])->count();

            $orderCount[$key] = Db::name('store_order')->where([
                ['status', '=', 'finish'],
                ['created_at', '>=', $value['start']],
                ['created_at', '<=', $value['end']]
            ])->count();

            $walletCount[$key] = Db::name('wallet')->where([
                ['created_at', '>=', $value['start']],
                ['created_at', '<=', $value['end']]
            ])->count();

            $storeCount[$key] = Db::name('store')->where([
                ['created_at', '>=', $value['start']],
                ['created_at', '<=', $value['end']]
            ])->count();
        }

        View::assign('member_count', $memberCount);
        View::assign('order_count', $orderCount);
        View::assign('wallet_count', $walletCount);
        View::assign('store_count', $storeCount);


        //當前可用
        $account['available'] = Db::name('account')->sum('available');
        $account['freeze'] = Db::name('account')->sum('freeze');
        $account['recharge'] = Db::name('account_recharge')->where(['status' => 'finish'])->sum('amount');
        $account['withdraw'] = Db::name('account_withdraw')->where(['status' => 'finish'])->sum('real_amount');
        View::assign('account', $account);
        return View();
    }

    //设置theme
    public function set_theme()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $admin = get_login_admin();
            Db::name('admin')->where('id', $admin['id'])->update(['theme' => $param['theme']]);
            return $this->success();
        } else {
            return $this->error('操作错误');
        }
    }

    public function status()
    {
        try {
            $param = get_param();
            if (empty($param['table']) || empty($param['id'])) {
                throw  new RespException(1, '參數錯誤');
            }

            $field = 'status';
            if (!empty($param['field'])) {
                $field = $param['field'];
            }
            $data = Db::name($param['table'])->where('id', $param['id'])->find();
            if (empty($data)) {
                throw  new RespException(1, '數據不存在');
            }
            $fieldValue = $data[$field] == 1 ? 0 : 1;
            Db::name($param['table'])->where('id', $param['id'])->update([$field => $fieldValue]);
            add_log('status', $param['id'], $param);
            return $this->success();
        } catch (\Exception $e) {
            return $this->error($e->getMessage());
        }
    }
}
