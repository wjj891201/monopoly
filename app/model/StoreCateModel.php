<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class StoreCateModel extends BaseModel
{
    protected $table = 'store_cate';


    public function getCateList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'sort_order desc,id desc' : $param['order'];
        $list = $this->where($where)
            ->order($order)
            ->paginate($rows);
        return $list;
    }


    public function addCate($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

    public function hasChild($id)
    {
        $count = $this->where(['pid' => $id])->count();
        return $count != 0;
    }

    public function editCate($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

}