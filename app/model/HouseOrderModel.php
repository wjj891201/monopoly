<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class HouseOrderModel extends BaseModel
{
    protected $table = 'house_order';

    public function getHouseOrderList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'o.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('o.id,o.order_no,o.price order_price,o.created_at,c.title cate_title,h.title house_name,m.username')
            ->alias('o')
            ->join('house_cate c', 'o.cate_id = c.id')
            ->join('house h', 'o.house_id = h.id')
            ->join('member m', 'o.member_id = m.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
