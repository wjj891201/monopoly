<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\ChainValidate;
use app\exception\RespException;
use app\model\ChainModel;
use think\facade\Db;
use think\facade\View;

class ChainController extends BaseController
{
    private ChainModel $chainModel;

    public function initialize()
    {
        parent::initialize();
        $this->chainModel = new ChainModel();
        $this->setTable($this->chainModel->getTable());
        $this->setValidate(validate(ChainValidate::class));
    }

    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->chainModel->getChainList();
            return $this->apiTable(['data' => $list]);
        } else {
            return view();
        }
    }


    public function delete()
    {
        $id = get_param('id');
        $ccItem = Db::name('currency_chain')->where('chain_id', $id)->find();
        if ($ccItem) {
            return $this->error('存在幣鏈數據，無法刪除');
        }
        return parent::delete();

    }
}