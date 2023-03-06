<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class SpotOrderModel extends BaseModel
{
    protected $table = 'spot_order';


    public function getOrderList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'o.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('o.*,m.username,p.code as pair_code,p.amount_decimal,p.last_price,
            p.price_decimal,bc.code as base_code,qc.code as quote_code')
            ->alias('o')
            ->leftJoin('spot_pair p', 'p.id = o.pair_id')
            ->leftJoin('member m', 'm.id = o.member_id')
            ->leftJoin('currency bc', 'bc.id = o.base_id')
            ->leftJoin('currency qc', 'qc.id = o.quote_id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function getOrderByWhere($where)
    {
        return $this->where($where)
            ->field('o.*,m.username,p.code as pair_code,p.amount_decimal,p.last_price,
                        p.price_decimal,bc.code as base_code,qc.code as quote_code')
            ->alias('o')
            ->leftJoin('spot_pair p', 'p.id = o.pair_id')
            ->leftJoin('member m', 'm.id = o.member_id')
            ->leftJoin('currency bc', 'bc.id = o.base_id')
            ->leftJoin('currency qc', 'qc.id = o.quote_id')
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