<?php

namespace app\store\controller;

use app\store\BaseController;
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
            $where = [['manager_id', '=', get_login_store('id')]];
            //获取账号关联的商户id
            $idArr = $this->storeService->storeModel->where(['manager_id' => get_login_store('id')])->column('id');
            $where = [['store_id', 'in', $idArr]];
            if (!empty($param['keywords'])) {
                $where[] = ['o.order_sn|m.username|s.title', 'like', '%' . $param['keywords'] . '%'];
            }
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