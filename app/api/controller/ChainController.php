<?php

namespace app\api\controller;

use app\api\BaseController;
use app\exception\RespException;
use app\service\CCService;
use app\validate\CommonValidate;

class ChainController extends BaseController
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
        $item = $this->ccService->getChainById($param['id']);
        if (empty($item) || $item['status'] == 0) {
            return $this->apiError('数据不存在');
        }
        $this->apiData($item);

    }

    public function list()
    {
        $list = $this->ccService->getChainList();
        if (empty($list)) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }

}