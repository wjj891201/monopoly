<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class NftOwnerModel extends BaseModel
{
    protected $table = 'nft_owner';
    protected $full;

    public function getOwnerList($where = [], $full = true)
    {
        $this->full = $full;
        $list = $this->where($where)->order(['sort_order'=>'desc','id'=>'desc'])->select();
        $temp = [];
        foreach ($list as $value) {
            $value = $this->handleData($value);
            $temp[] = $value;
        }
        return $temp;
    }

    public function getOwnerById($id, $full = true)
    {
        $this->full = $full;
        $item = $this->where('id', $id)->find();
        if (!empty($item)) {
            return $this->handleData($item);
        } else {
            throw new RespException(1, '公鏈不存在');
        }
    }

    public function addOwner($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $id = $this->strict(false)->insertGetId($data);
            add_log('add', $id, $data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editOwner($data)
    {
        if (empty($data) || !isset($data['id'])) {
            throw new RespException(1, '參數不正確');
        }
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
            add_log('edit', $data['id'], $data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

    public function deleteOwner($id)
    {
        if (empty($id)) {
            throw new RespException(1, '參數不正確');
        }
        try {
            $data = $this->getOwnerById($id);
            $this->where('id', $id)->delete();
            add_log('delete', $id, $data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

    public function handleData($item)
    {
        if (!$this->full) {
            unset($item['created_at'], $item['updated_at']);
        }
        return $item;
    }
}