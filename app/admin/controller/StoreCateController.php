<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\StoreCateModel;

class StoreCateController extends BaseController
{
    private StoreCateModel $cateModel;

    public function initialize()
    {
        parent::initialize();
        $this->cateModel = new StoreCateModel();
        $this->setTable($this->cateModel->getTable());
    }

    public function list(){
        if (request()->isAjax()) {
            $list = $this->cateModel->getCateList();
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}