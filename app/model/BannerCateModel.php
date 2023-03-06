<?php


namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class BannerCateModel extends BaseModel
{
    protected $table = 'banner_cate';

    public function getCateList($where = [])
    {
        $list = $this->where($where)->order(['id' => 'desc'])->select();
        return $list;
    }


    public function addCate($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }


    public function editCate($data)
    {
        try {
            $data['updated_at'] = Carbon::now()->toDateTimeString();
            $this->where('id', $data['id'])->strict(false)->field(true)->update($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}
