<?php

namespace app\model;

use app\exception\RespException;
use Carbon\Carbon;
use think\Model;

class VerifyCodeModel extends BaseModel
{
    protected $table = 'verify_code';


    public function addCode($data)
    {
        try {
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['expire_at'] = Carbon::now()->addMinutes(3)->toDateTimeString();
            return $this->strict(false)->insertGetId($data);
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }
}