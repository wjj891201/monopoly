<?php

namespace app\model;

use Carbon\Carbon;
use think\Model;

class AccountLogModel extends BaseModel
{
    protected $table = 'account_log';

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
    public function getLogList($where, $param)
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'l.id desc' : $param['order'];
        $list = self::where($where)
            ->field('l.*,m.username')
            ->alias('l')
            ->leftJoin('member m', 'l.member_id = m.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }
}