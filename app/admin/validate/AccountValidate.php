<?php

namespace app\admin\validate;

use think\Validate;

class AccountValidate extends Validate
{
    protected $rule = [
        'id' => 'require',
        'balance_type' => 'require|in:available,freeze',
        'operate_type' => 'require|in:add,sub',
        'amount' => 'require|float',

    ];

    protected $message = [
        'id.require' => '參數不正確',
        'balance_type.require' => '餘額類型不正確',
        'operate_type.require' => '操作類型不正確',
        'amount.require' => '數量不能為空',
        'amount.float' => '數量格式不正確',
    ];

    protected $scene = [
        'update' => ['id', 'balance_type', 'operate_type', 'amount'],
    ];


}