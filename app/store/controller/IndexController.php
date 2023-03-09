<?php


declare (strict_types=1);

namespace app\store\controller;

use app\store\BaseController;
use app\exception\RespException;
use think\facade\App;
use think\facade\Cache;
use think\facade\Db;
use think\facade\View;

class IndexController extends BaseController
{
    public function index()
    {
        $store = get_login_store();
        if (get_cache('store_menu' . $store['id'])) {
            $list = get_cache('store_menu' . $store['id']);
        } else {
            $menu = Db::name('store_menu')->where(['menu' => 1, 'status' => 1])->order('sort_order asc')->select()->toArray();
            $list = list_to_tree($menu);
            Cache::tag('storeMenu')->set('store_menu' . $store['id'], $list);
        }
        View::assign('theme', 'black');
        View::assign('menu', $list);
        return View();
    }

    public function main()
    {
        $adminCount = Db::name('admin')->where('status', '1')->count();
        $userCount = Db::name('member')->where('status', '1')->count();
        $articleCount = Db::name('article')->where('status', '1')->count();
        $fileCount = Db::name('file')->count();
        View::assign('adminCount', $adminCount);
        View::assign('userCount', $userCount);
        View::assign('articleCount', $articleCount);
        View::assign('fileCount', $fileCount);
        View::assign('TP_VERSION', App::version());
        return View();
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
