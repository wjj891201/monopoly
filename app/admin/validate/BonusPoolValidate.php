<?php


namespace app\admin\validate;

use think\Validate;

class BonusPoolValidate extends BaseValidate
{
    protected $rule = [
        'flow' => 'require',
        'price' => 'require',
    ];

    protected $message = [
        'flow.require' => '請選擇狀態',
        'price.require' => '金額不能為空',
    ];
}
