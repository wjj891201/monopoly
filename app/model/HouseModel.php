<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class HouseModel extends BaseModel
{
    protected $table = 'house';

    public function getHouseList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'a.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('a.*,c.id as cate_id,c.title as cate_title,u.nickname as admin_name,m.username')
            ->alias('a')
            ->join('house_cate c', 'a.cate_id = c.id')
            ->join('admin u', 'a.admin_id = u.id', 'LEFT')
            ->join('member m', 'a.owner_id = m.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

}
