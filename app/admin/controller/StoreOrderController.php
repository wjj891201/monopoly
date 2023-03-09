<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\MemberModel;
use app\model\StoreOrderModel;
use app\service\StoreService;

class StoreOrderController extends BaseController
{
    protected StoreOrderModel $orderModel;
    protected StoreService $storeService;

    protected function initialize()
    {
        parent::initialize();
        $this->orderModel = new StoreOrderModel();
        $this->storeService = new StoreService();
        $this->setTable($this->orderModel->getTable());
    }

    public function list()
    {
        $param = get_param();

        if (request()->isAjax()) {

            $where = search_where($param,[
                ['o.order_sn|m.username|s.title', 'like', 'keywords'],
            ]);

            $list = $this->storeService->getOrderList($where, $param);
            foreach ($list as $key => $value) {
                $manager = (new MemberModel())->find($value['manager_id']);
                $value['manager_username'] = $manager['username'];
                $list[$key] = $value;
            }
            return $this->apiTable($list);
        } else {
            return view();
        }
    }


    public function initForm($item)
    {
        $item = parent::initForm($item);
        $item = $this->storeService->getOrderById($item['id']);
        return $item;
    }
}