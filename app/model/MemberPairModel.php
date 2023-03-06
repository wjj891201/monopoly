<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class MemberPairModel extends BaseModel
{
    protected $table = 'member_pair';


    public function getPairByMemberID($member_id, $pair_id, $cate)
    {
        $item = $this->where([
            'member_id' => $member_id,
            'pair_id' => $pair_id,
            'cate' => $cate
        ])->find();

        return $item;
    }

    public function addPair($param)
    {
        try {
            $param['created_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($param);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}