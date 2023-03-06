<?php

namespace app\api\controller;

use app\api\BaseController;
use app\exception\RespException;
use app\service\CCService;
use app\validate\CommonValidate;

class CurrencyController extends BaseController
{
    private CCService $ccService;

    public function initialize()
    {
        parent::initialize();
        $this->ccService = new CCService(false);
    }

    public function info()
    {
        try {
            $param = get_param();
            validate(CommonValidate::class)->scene('id')->check($param);

            $item = $this->ccService->getCurrencyById($param['id']);
            if (empty($item)) {
                throw new RespException(1, '數據不存在');
            }
            return $this->apiData($item);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function list()
    {
        $param = get_param();
        $where = [];

        if (!empty($param['is_recharge'])) {
            $where[] = ['is_recharge', '=', 1];
        } elseif (!empty($param['is_withdraw'])) {
            $where[] = ['is_withdraw', '=', 1];
        } elseif (!empty($param['is_transfer'])) {
            $where[] = ['is_transfer', '=', 1];
        } elseif (!empty($param['is_trade'])) {
            $where[] = ['is_trade', '=', 1];
        }


        $list = $this->ccService->getCurrencyList($where);
        if (count($list) == 0) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }

}