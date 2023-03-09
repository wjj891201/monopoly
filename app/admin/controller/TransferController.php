<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\AccountTransferModel;

class TransferController extends BaseController
{
    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = search_where($param,[
                ['username', 'like', 'keywords'],
            ]);
            $transferModel = new AccountTransferModel();
            $list = $transferModel->getTransferList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }
}