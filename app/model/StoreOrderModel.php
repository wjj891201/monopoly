<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class StoreOrderModel extends BaseModel
{
    protected $table = 'store_order';


    public function getOrderList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'o.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('o.*,m.username,s.title as store_name,s.manager_id')
            ->alias('o')
            ->leftJoin('member m', 'm.id = o.member_id')
            ->leftJoin('store s', 's.id = o.store_id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function getOrderByWhere($where)
    {
        return $this->where($where)
            ->field('o.*,m.username,s.title as store_name')
            ->alias('o')
            ->leftJoin('member m', 'm.id = o.member_id')
            ->leftJoin('store s', 's.id = o.store_id')
            ->find();
    }

    public function getOrderByID($id)
    {
        return $this->getOrderByWhere(['o.id' => $id]);
    }

    public function getOrderBySN($orderSN)
    {
        return $this->getOrderByWhere(['o.order_sn' => $orderSN]);
    }

    public function addOrder($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editOrder($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}