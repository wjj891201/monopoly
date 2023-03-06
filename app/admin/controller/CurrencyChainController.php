<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\CurrencyChainValidate;
use app\exception\RespException;
use app\model\ChainModel;
use app\model\CurrencyChainModel;
use app\model\CurrencyModel;
use think\facade\View;

class CurrencyChainController extends BaseController
{
    private CurrencyChainModel $ccModel;

    public function initialize()
    {
        parent::initialize();
        $this->ccModel = new CurrencyChainModel();
        $this->setTable($this->ccModel->getTable());
        $this->setValidate(validate(CurrencyChainValidate::class));
    }

    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->ccModel->getCurrencyChainList();
            return $this->apiTable(['data' => $list]);
        } else {
            return view();
        }
    }

    public function initForm($item)
    {
        $chain_list = (new ChainModel())->getChainList(['status' => 1]);
        View::assign('chain_list', $chain_list);

        $currency_list = (new CurrencyModel())->getCurrencyList(['status' => 1]);
        View::assign('currency_list', $currency_list);

        return $item;
    }


}