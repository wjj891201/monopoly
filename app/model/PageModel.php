<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\model;

class PageModel extends BaseModel
{

    protected $table = 'page';

    public function getPageList($where, $param)
    {
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $order = empty($param['order']) ? 'id desc' : $param['order'];
        $list = $this->where($where)
            ->order($order)
            ->paginate($rows);
        return $list;
    }

    public function addPage($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editPage($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}

