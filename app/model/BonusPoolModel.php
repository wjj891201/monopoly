<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class BonusPoolModel extends BaseModel
{
    protected $table = 'bonus_pool';

    public function getBonusPoolList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'b.id desc' : $param['order'];
        $list = $this->where($where)
            ->field("b.id,b.price,b.flow,b.created_at,a.username a_username,m.username m_username,(CASE WHEN b.flow=1 THEN '增加' WHEN b.flow=0 THEN '減少' ELSE '' END) AS flow_ch")
            ->alias('b')
            ->join('admin a', 'b.admin_id = a.id', 'LEFT')
            ->join('member m', 'b.member_id = m.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
