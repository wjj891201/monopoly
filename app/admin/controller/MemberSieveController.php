<?php

namespace app\admin\controller;

use app\admin\BaseController;

//use app\model\ChainModel;
use app\model\MemberSieveModel;
use think\facade\Db;
use think\facade\View;

class MemberSieveController extends BaseController
{
    private MemberSieveModel $sieveModel;

    public function initialize()
    {
        parent::initialize();
        $this->sieveModel = new MemberSieveModel();
        $this->setTable($this->sieveModel->getTable());
    }

    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [

            ]);
            $list = $this->sieveModel->getMemberSieveList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }
}