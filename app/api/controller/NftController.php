<?php

namespace app\api\controller;

use app\api\BaseController;
use app\model\ChainModel;
use app\model\NftContractModel;
use app\model\NftOwnerModel;

class NftController extends BaseController
{
    private NftContractModel $contractModel;
    private NftOwnerModel $ownerModel;

    public function initialize()
    {
        parent::initialize();
        $this->contractModel = new NftContractModel();
        $this->ownerModel = new NftOwnerModel();
    }

    public function contractList()
    {
        $list = $this->contractModel->getContractList(['status' => 1],false);
        if (count($list) == 0){
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }

    public function contractInfo()
    {
        $id = intval(get_param('id'));
        if (empty($id)) {
            return $this->apiError('參數不正確');
        }

        $item = $this->contractModel->getContractById($id, false);
        if ($item['status'] != 1) {
            return $this->apiError('參數不正確');
        }
        return $this->apiData($item);
    }

    public function list()
    {
        $list = $this->ownerModel->getOwnerList(['status' => 1],false);
        if (count($list) == 0){
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }
}