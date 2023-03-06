<?php

namespace app\api\controller;

use app\model\AccountRewardModel;

class RewardController extends CommonController
{
    protected AccountRewardModel $rewardModel;

    public function initialize()
    {
        parent::initialize();
        $this->rewardModel = new AccountRewardModel();
    }

    public function list()
    {
        $param = get_param();
        try {

            $where[] = ['r.member_id','=',JWT_UID];
            $list = $this->rewardModel->getRewardList($where,$param);
            return $this->apiData($list);

        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}