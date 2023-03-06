<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class MemberAddressModel extends BaseModel
{
    protected $table = 'member_address';

    public function getAddressList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'a.id desc' : $param['order'];
        $list = self::where($where)
            ->field('a.*,c.base_chain')
            ->alias('a')
            ->join('chain c', 'a.chain_id = c.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

    public function addAddress($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editAddress($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

}