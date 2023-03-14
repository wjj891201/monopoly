<?php

namespace app\api\validate;

use app\BaseValidate;

class StoreValidate extends BaseValidate
{
    protected $rule = [
        'member_id' => 'require',
        'store_id' => 'require',
        'amount' => 'require|float',

    ];

    protected $message = [
        'member_id.require' => '用戶不存在',
        'store_id.require' => '商戶不存在',
        'amount.require' => '請輸入金額',
        'amount.float' => '金額格式不正確',
    ];
}