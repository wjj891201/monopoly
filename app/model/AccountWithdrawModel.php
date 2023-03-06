<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class AccountWithdrawModel extends BaseModel
{
    protected $table = 'account_withdraw';


    public function getWithdrawList($where, $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'w.id desc' : $param['order'];
        $list = self::where($where)
            ->field('w.*,m.username,cc.display_name as cc_name')
            ->alias('w')
            ->leftJoin('member m', 'w.member_id = m.id')
            ->leftJoin('currency_chain cc', 'w.cc_id = cc.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function addWithdraw($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editWithdraw($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }



}