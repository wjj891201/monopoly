<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class SellCardUseModel extends BaseModel
{

    protected $table = 'sell_card_use';

    public function getSellCardUseList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'o.id desc' : $param['order'];
        $list = $this->where($where)
            ->field("u.id,u.date_start,u.date_end,u.created_at,o.order_no,h.title,m.username")
            ->alias('u')
            ->join('sell_card_order o', 'u.order_id = o.id')
            ->join('house h', 'u.house_id = h.id')
            ->join('member m', 'u.member_id = m.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
