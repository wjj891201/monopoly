<?php

namespace app\api\controller;

use app\service\SpotService;
use app\exception\RespException;
use app\api\controller\CommonController;

class SpotPairController extends CommonController
{
    private SpotService $spotService;

    public function initialize()
    {
        parent::initialize();
        $this->spotService = new SpotService(false);
    }

    public function info()
    {
        $pair = get_param('pair');
        if (empty($pair)) {
            return $this->apiError('参数错误');
        }
        $item = $this->spotService->getPairByCode($pair);
        if (empty($item) || $item['is_show'] == 0) {
            return $this->apiError('数据不存在');
        }
        $this->apiData($item);
    }

    public function list()
    {
        $list = $this->spotService->getPairList();
        if (empty($list)) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }
}
