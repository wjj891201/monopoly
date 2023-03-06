<?php

namespace app\model;

use Carbon\Carbon;
use think\Model;

class AccountRechargeModel extends BaseModel
{
    protected $table = 'account_recharge';

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
    public function getRechargeList($where, $param)
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'r.id desc' : $param['order'];
        $list = self::where($where)
            ->field('r.*,m.username')
            ->alias('r')
            ->leftJoin('member m', 'r.member_id = m.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }
}