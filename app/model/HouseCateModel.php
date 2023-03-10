<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class HouseCateModel extends BaseModel
{

    protected $table = 'house_cate';


    public function getCateList($where = [])
    {
        return $this->where($where)->order('sort_order asc')->select();
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
