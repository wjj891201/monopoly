<?php


namespace app\admin\validate;

//use think\Validate;

class SellCardValidate extends BaseValidate
{
    protected $rule = [
        'day' => 'require|unique:sell_card',
        'price' => 'require',
        'status' => 'require'
    ];

    protected $message = [
        'day.require' => '天數不能為空',
        'day.unique' => '該天數已存在',
        'price.require' => '價格不能為空',
        'status.require' => '請選擇狀態',
    ];
}
