<?php

namespace app\admin\validate;

use think\Validate;

class CurrencyValidate extends Validate
{
    protected $rule = [
        'name_cn' => 'require',
        'name_en' => 'require',
        'code' => 'require',
        'decimal' => 'require',
    ];

    protected $message = [
        'name_cn.require' => '中文名稱不能為空',
        'name_en.require' => '英文名稱不能為空',
        'code.require' => '標識符不能為空',
        'decimal.require' => '小數位不能為空',
    ];
}