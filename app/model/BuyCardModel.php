<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class BuyCardModel extends BaseModel
{

    protected $table = 'buy_card';

    public function getBuyCardList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'b.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('b.*,u.nickname as admin_name')
            ->alias('b')
            ->join('admin u', 'b.admin_id = u.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
