<?php

namespace app\admin\controller;

use think\facade\View;
use think\facade\Config;
use app\facade\MutexFacade;
use app\model\AccountModel;
use app\admin\BaseController;
use app\service\AccountService;
use app\admin\validate\AccountValidate;


class AccountController extends BaseController
{
    public function index()
    {

        if (request()->isAjax()) {
            $param = get_param();
            $where = [];
            if (!empty($param['keywords'])) {
                $where[] = ['m.username', 'like', '%' . $param['keywords'] . '%'];
            }
            $list = (new AccountService())->getAccountList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

    /**
     * 编辑
     */
    public function edit()
    {
        $param = get_param();

        if (request()->isAjax()) {
            try {
                validate(AccountValidate::class)->scene('update')->check($param);
                $account = (new AccountModel())->find($param['id']);

                $mutex = MutexFacade::create("account_change");
                if ($mutex->acquireLock(Config::get('mutex.timeout'))) {
                    (new AccountService())->updateAccount([
                        'member_id' => $account['member_id'],
                        'scene' => '後台',
                        'asset_type' => $account['asset_type'],
                        'balance_type' => $param['balance_type'],
                        'operate_type' => $param['operate_type'],
                        'currency_id' => $account['currency_id'],
                        'amount' => $param['amount'],
                        'item_id' => get_login_admin('id'),
                        'remark' => $param['remark'],
                    ]);
                    add_log('edit', $account['member_id'], $param);
                    $mutex->releaseLock();
                    return $this->success();
                }
            } catch (\Exception $e) {
                return $this->error($e->getMessage());
            }
        } else {
            $id = $param['id'] ?? 0;
            $item = (new AccountService())->getAccountById($id);
            View::assign('item', $item);
            return view();
        }
    }
}
