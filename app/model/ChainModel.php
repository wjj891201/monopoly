<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class ChainModel extends BaseModel
{
    protected $table = 'chain';

    public function getChainList($where = [])
    {
        return $this->where($where)->order(['sort_order' => 'desc', 'id' => 'desc'])->select();
    }


    public function addChain($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editChain($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

}