<?php

namespace app\admin\validate;

use think\Validate;

class ChainValidate extends Validate
{

    protected $rule = [
        'chain_name' => 'require',
        'base_chain' => 'require',
        'base_chain_protocol' => 'require',
    ];

    protected $message = [
        'chain_name.require' => '名稱不能為空',
        'base_chain.require' => '公鏈標識符不能為空',
        'base_chain_protocol.require' => '底層協議不能為空',
    ];
}