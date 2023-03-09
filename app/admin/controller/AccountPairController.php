<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\AccountPairValidate;
use app\model\AccountPairModel;
use app\model\AccountRechargeModel;
use app\model\StoreModel;
use app\service\StoreService;

class AccountPairController extends BaseController
{

    private AccountPairModel $pairModel;

    public function initialize()
    {
        parent::initialize();
        $this->pairModel = new AccountPairModel();
        $this->setTable($this->pairModel->getTable());
        $this->setValidate(validate(AccountPairValidate::class));
    }

    public function list()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = search_where($param, [
                ['p.name', 'like', 'keywords']
            ]);
            $list = $this->pairModel->getPairList($where);
            return $this->apiTable(['data' => $list]);
        } else {
            return view();
        }
    }
}