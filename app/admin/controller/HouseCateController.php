<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\HouseCateValidate;
use app\exception\RespException;
use app\model\HouseCateModel;

use think\Exception;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\View;

class HouseCateController extends BaseController
{
    private HouseCateModel $cateModel;

    public function initialize()
    {
        parent::initialize();
        $this->cateModel = new HouseCateModel();
        $this->setTable($this->cateModel->getTable());
        $this->setValidate(validate(HouseCateValidate::class));
    }


    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->cateModel->getCateList();
            return $this->success('', $list);
        } else {
            return view();
        }
    }

}
