<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;

class AccountRewardModel extends BaseModel
{
    protected $table = 'account_reward';

    public function createReward($data)
    {
        $data['created_at'] = Carbon::now()->toDateTimeString();
        return $this->strict(false)->field(true)->insertGetId($data);
    }

    /**
     * @param $where
     * @param $param
     * @return mixed
     */
    public function getRewardList($where, $param)
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'r.id desc' : $param['order'];
        $list = self::where($where)
            ->field('r.*,mt.username,mf.username as from_username')
            ->alias('r')
            ->leftJoin('member mt', 'r.member_id = mt.id')
            ->leftJoin('member mf', 'r.from_member_id = mf.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }

    public function addReward($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

    public function sumReward($where)
    {
        return $this->where($where)->sum('amount');
    }
}