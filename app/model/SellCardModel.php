<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class SellCardModel extends BaseModel
{

    protected $table = 'sell_card';

    public function getSellCardList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 's.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('s.*,u.nickname as admin_name')
            ->alias('s')
            ->join('admin u', 's.admin_id = u.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
