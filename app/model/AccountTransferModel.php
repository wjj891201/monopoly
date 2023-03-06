<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class AccountTransferModel extends BaseModel
{
    protected $table = 'account_transfer';

    public function createLog($data)
    {
        $data['created_at'] = Carbon::now()->toDateTimeString();
        return $this->strict(false)->field(true)->insertGetId($data);

    }

    /**
     * @param $where
     * @param $param
     * @return mixed
     */
    public function getTransferList($where, $param)
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'id desc' : $param['order'];
        $list = self::where($where)
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function addTransfer($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}