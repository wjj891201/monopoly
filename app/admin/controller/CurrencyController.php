<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\CurrencyValidate;
use app\model\CurrencyModel;
use think\facade\Db;

class CurrencyController extends BaseController
{
    private CurrencyModel $currencyModel;

    public function initialize()
    {
        parent::initialize();
        $this->currencyModel = new CurrencyModel();
        $this->setTable($this->currencyModel->getTable());
        $this->setValidate(validate(CurrencyValidate::class));
    }

    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->currencyModel->getCurrencyList();
            return $this->apiTable(['data' => $list]);
        } else {
            return view();
        }
    }


    public function delete()
    {
        $id = get_param('id');
        $ccItem = Db::name('currency_chain')->where('currency_id', $id)->find();
        if ($ccItem) {
            return $this->error('存在幣鏈數據，無法刪除');
        }
        return parent::delete();
    }
}
