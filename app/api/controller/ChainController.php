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
        try {
            $param = get_param();
            validate(CommonValidate::class)->scene("id")->check($param);

            $item = $this->ccService->getChainById($param['id']);
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
        $list = $this->ccService->getChainList();
        if (count($list) == 0) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }

}