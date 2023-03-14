<?php

namespace app\api\validate;

use think\Validate;

class AddressValidate extends Validate
{
    protected $rule = [
        'chain_id' => 'require',
        'name' => 'require',
        'address' => 'require',
    ];

    protected $message = [
        'chain_id.require' => '公鏈不能為空',
        'name.require' => '名稱不能為空',
        'address.require' => '地址不能為空',
    ];
}