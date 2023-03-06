<?php

namespace app\model;

class WalletTransactionModel extends BaseModel
{
    protected $table = 'wallet_transaction';

    protected $full;


    public function getTransactionList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'id desc' : $param['order'];
        $list = $this->where($where)
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function getTransaction($where = [])
    {
        return $this->where($where)->find();
    }
}