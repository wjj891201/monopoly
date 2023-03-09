<?php

namespace app\api\controller;

use app\model\AccountRechargeModel;

class RechargeController extends CommonController
{
    protected AccountRechargeModel $rechargeModel;
    
    public function initialize()
    {
        parent::initialize();
        $this->rechargeModel = new AccountRechargeModel();
    }
    
    public function list()
    {
        $param = get_param();
        $where[] = ['r.member_id','=',JWT_UID];
        $list = $this->rechargeModel->getRechargeList($where,$param);
        return $this->apiData($list);
    }
}