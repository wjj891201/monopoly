<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Exception;
use think\Model;

class AccountModel extends BaseModel
{
    protected $table = 'account';


    public function getAccountList($where, $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'a.id desc' : $param['order'];
        $list = self::where($where)
            ->field('a.*,m.username,c.decimal')
            ->alias('a')
            ->leftJoin('member m', 'a.member_id = m.id')
            ->leftJoin('currency c', 'a.currency_id = c.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

    public function getAccountByID($id)
    {
        return self::where([['id', '=', $id]])
            ->field('a.*,m.username,c.decimal')
            ->alias('a')
            ->leftJoin('member m', 'a.member_id = m.id')
            ->leftJoin('currency c', 'a.currency_id = c.id')
            ->find();
    }


    public function updateAccount($param)
    {
        $param['updated_at'] = Carbon::now()->toDateTimeString();
        $this->where('id', $param['id'])->strict(false)->field(true)->update($param);

    }


    public function createAccount($data)
    {
        $data['created_at'] = Carbon::now()->toDateTimeString();
        $data['updated_at'] = Carbon::now()->toDateTimeString();
        return $this->strict(false)->field(true)->insertGetId($data);
    }

}