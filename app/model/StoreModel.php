<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class StoreModel extends BaseModel
{
    protected $table = 'store';

    public function getStoreList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 's.sort_order desc,s.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('s.*,c.id as cate_id,c.title as cate_title,u.nickname as admin_name,m.username as manager_username')
            ->alias('s')
            ->leftJoin('store_cate c', 's.cate_id = c.id')
            ->leftJoin('admin u', 's.admin_id = u.id')
            ->leftJoin('member m', 's.manager_id = m.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

    public function addStore($param)
    {
        try {
            $param['created_at'] = Carbon::now()->toDateTimeString();
            $param['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($param);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editStore($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

}