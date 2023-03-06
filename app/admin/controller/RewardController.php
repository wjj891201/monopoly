<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\AccountRewardModel;

class RewardController extends BaseController
{
    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = [];
            if (!empty($param['keywords'])) {
                $where[] = ['mt.username', 'like', '%' . $param['keywords'] . '%'];
            }

            $rewardModel = new AccountRewardModel();
            $list = $rewardModel->getRewardList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }
}