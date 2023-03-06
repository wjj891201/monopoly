<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class AccountPairModel extends BaseModel
{
    protected $table = 'account_pair';


    public function getPairList($where)
    {
        $order = empty($param['order']) ? 'p.sort_order desc,p.id desc' : $param['order'];
        $list = self::where($where)
            ->field('p.*,cc.display_name as cc_name')
            ->alias('p')
            ->leftJoin('currency_chain cc', 'p.cc_id = cc.id')
            ->order($order)
            ->select();
        return $list;
    }


    public function addPair($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editPair($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}