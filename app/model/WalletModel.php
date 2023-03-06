<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class WalletModel extends BaseModel
{
    protected $table = 'wallet';

    protected $full;


    public function getWalletList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'w.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('w.*,m.username,c.text_color,c.address_color,c.bg_color,c.base_chain')
            ->alias('w')
            ->leftJoin('member m', 'w.member_id = m.id')
            ->leftJoin('chain c', 'w.chain_id = c.id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function getWallet($where = [])
    {
        return $this->where($where)
            ->field('w.*,m.username,c.text_color,c.address_color,c.bg_color,c.base_chain')
            ->alias('w')
            ->leftJoin('member m', 'w.member_id = m.id')
            ->leftJoin('chain c', 'w.chain_id = c.id')
            ->find();
    }

    public function getDefaultWallet($memberID)
    {
        return $this->where("member_id", $memberID)->order(["is_default" => "desc", "id" => "desc"])->find();
    }


    public function addWallet($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editWallet($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

}