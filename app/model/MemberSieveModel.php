<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class MemberSieveModel extends BaseModel
{
    protected $table = 'member_sieve';

    public function getMemberSieveList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 's.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('s.*,m.username')
            ->alias('s')
            ->join('member m', 's.member_id = m.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }
}