<?php


namespace app\admin\validate;

//use think\Validate;

class BuyCardValidate extends BaseValidate
{
    protected $rule = [
        'num' => 'require|unique:buy_card',
        'price' => 'require',
        'status' => 'require'
    ];

    protected $message = [
        'num.require' => '個數不能為空',
        'num.unique' => '該個數已存在',
        'price.require' => '價格不能為空',
        'status.require' => '請選擇狀態',
    ];
}
