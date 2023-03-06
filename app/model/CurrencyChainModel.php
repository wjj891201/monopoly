<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class CurrencyChainModel extends BaseModel
{
    public $table = 'currency_chain';

    public function getCurrencyChainList($where = [])
    {

        $order = empty($param['order']) ? 'cc.id desc' : $param['order'];
        $list = self::where($where)
            ->field('cc.*,c.code as currency_code,c.name_cn as currency_name,c2.chain_name,c2.base_chain,c2.base_chain_protocol')
            ->alias('cc')
            ->leftJoin('currency c', 'cc.currency_id = c.id')
            ->leftJoin('chain c2', 'cc.chain_id = c2.id')
            ->order($order)
            ->select();
        return $list;
    }


    public function getCurrencyChain($where = [])
    {
        $item = $this->where($where)
            ->field('cc.*,c.code as currency_code,c.decimal as currency_decimal,c.name_cn as currency_name,c2.chain_name,c2.base_chain,c2.base_chain_protocol')
            ->alias('cc')
            ->leftJoin('currency c', 'cc.currency_id = c.id')
            ->leftJoin('chain c2', 'cc.chain_id = c2.id')
            ->order('cc.id desc')
            ->find();
        return $item;
    }


    public function addCurrencyChain($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editCurrencyChain($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


}