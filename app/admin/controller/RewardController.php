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

            $where = search_where($param,[
                ['mt.username', 'like', 'keywords'],
            ]);

            $rewardModel = new AccountRewardModel();
            $list = $rewardModel->getRewardList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }
}