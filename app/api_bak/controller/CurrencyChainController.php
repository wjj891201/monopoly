<?php

namespace app\api\controller;

use app\api\BaseController;
use app\exception\RespException;
use app\service\CCService;
use app\validate\CommonValidate;

class CurrencyChainController extends BaseController
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
        $item = $this->ccService->getCurrencyChainByID($param['id']);
        if (empty($item) || $item['status'] == 0) {
            $this->apiError('數據不存在');
        }
        return $this->apiData($item);
    }

    public function list()
    {
        $param = get_param();

        $where = search_where($param,[
           ['cc.currency_id'],
           ['cc.chain_id']
        ]);

        $list = $this->ccService->getCurrencyChainList($where);
        if (count($list) == 0) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }
}