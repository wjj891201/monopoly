<?php

namespace app\api\validate;

use app\BaseValidate;

class AddressValidate extends BaseValidate
{
    protected $rule = [
        'chain_id' => 'require',
        'name' => 'require',
        'address' => 'require',
    ];

    protected $message = [
        'chain_id' => '公鏈不正確',
        'name.require' => '名稱不能為空',
        'address.require' => '地址不能為空',
    ];
}