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
        $param = get_param();
        if (empty($param['id'])) {
            return $this->apiError('参数错误');
        }
        $item = $this->ccService->getCurrencyById($param['id']);
        if (empty($item) || $item['status'] == 0) {
            $this->apiError('數據不存在');
        }
        return $this->apiData($item);
    }

    public function list()
    {
        $param = get_param();
        $where = search_where($param,[
            ['is_recharge'],
            ['is_withdraw'],
            ['is_trade'],
        ]);
        $list = $this->ccService->getCurrencyList($where);
        if (empty($list)) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }

}