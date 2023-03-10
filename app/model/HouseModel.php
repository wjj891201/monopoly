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
            ->join('admin u', 'a.admin_id = u.id')
            ->join('member m', 'a.owner_id = m.id', 'LEFT')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

//    public function addHouse($param)
//    {
//        try {
//            $param['created_at'] = Carbon::now()->toDateTimeString();
//            $param['updated_at'] = Carbon::now()->toDateTimeString();
//            return $this->strict(false)->insert($param);
//        } catch (\Exception $e) {
//            throw new RespException(1, $e->getMessage());
//        }
//    }
//
//
//    public function editHouse($data)
//    {
//        try {
//            $data['updated_at'] = Carbon::now()->toDateTimeString();
//            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
//        } catch (\Exception $e) {
//            throw new RespException(1, $e->getMessage());
//        }
//    }
}
