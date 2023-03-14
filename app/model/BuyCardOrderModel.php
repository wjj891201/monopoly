<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class BuyCardOrderModel extends BaseModel
{

    protected $table = 'buy_card_order';

    public function getBuyCardOrderList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'o.id desc' : $param['order'];
        $list = $this->where($where)
            ->field("o.*,(CASE WHEN o.status=1 THEN '已支付' WHEN o.status=0 THEN '待支付' ELSE '' END) AS statu_ch,m.username")
            ->alias('o')
            ->join('member m', 'o.member_id = m.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
