<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;


class SpotPairModel extends BaseModel
{
    protected $table = 'spot_pair';

    public function getPairList($where = [])
    {
        $list = $this->where($where)
            ->field('p.*,bc.code as base_code,qc.code as quote_code')
            ->alias('p')
            ->leftJoin('currency bc', 'bc.id = p.base_id')
            ->leftJoin('currency qc', 'qc.id = p.quote_id')
            ->order(['p.sort_order' => 'desc', 'p.id' => 'desc'])
            ->select();

        return $list;
    }

    public function getPairByWhere($where)
    {
        $item = $this->where($where)
            ->field('p.*,bc.code as base_code,qc.code as quote_code')
            ->alias('p')
            ->leftJoin('currency bc', 'bc.id = p.base_id')
            ->leftJoin('currency qc', 'qc.id = p.quote_id')
            ->find();

        return $item;
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