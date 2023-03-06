<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\AccountRechargeModel;
use Carbon\Carbon;

class RechargeController extends BaseController
{
    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = [];
            if (!empty($param['keywords'])) {
                $where[] = ['m.username', 'like', '%' . $param['keywords'] . '%'];
            }
            $rechargeModel = new AccountRechargeModel();
            $list = $rechargeModel->getRechargeList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}