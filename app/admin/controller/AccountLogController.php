<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\AccountLogModel;

class AccountLogController extends BaseController
{
    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();

            $where = search_where($param,[
                ['m.username', 'like', 'keywords'],
            ]);

            $accountLogModel = new AccountLogModel();
            $list = $accountLogModel->getLogList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }
}
