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
        try {
            $param = get_param();
            validate(CommonValidate::class)->scene('id')->check($param);

            $item = $this->ccService->getCurrencyChainByID($param['id']);
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
        if (isset($param['currency_id']) && !empty($param['currency_id'])) {
            $where[] = ['cc.currency_id', '=', $param['currency_id']];
        }

        if (isset($param['chain_id']) && !empty($param['chain_id'])) {
            $where[] = ['cc.chain_id', '=', $param['chain_id']];
        }
        $list = $this->ccService->getCurrencyChainList($where);
        if (count($list) == 0) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }
}