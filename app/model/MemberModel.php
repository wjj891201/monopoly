<?php


namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class MemberModel extends BaseModel
{
    protected $table = 'member';

    public function getMemberList($where = [], $param = [])
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'm.id desc' : $param['order'];
        $list = $this->where($where)
            ->field('m.*,r.name as role_name')
            ->alias('m')
            ->leftJoin('member_role r', 'r.id = m.role_id')
            ->order($order)
            ->paginate($rows, false, ['query' => $param]);
        return $list;
    }


    public function getMemberByID($id)
    {
        $item = $this->where([['m.id', '=', $id]])
            ->field('m.*,r.name as role_name')
            ->alias('m')
            ->leftJoin('member_role r', 'r.id = m.role_id')
            ->find();
        return $item;
    }


    public function countMemberByRole($role)
    {
        return $this->countMemberByWhere([['role_id', '=', $role]]);
    }


    public function countMemberByWhere($where)
    {
        return $this->where($where)->field('id')->count();
    }


    public function editMember($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

    public function addMember($data)
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