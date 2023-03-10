<?php


namespace app\admin\validate;

//use think\Validate;

class HouseCateValidate extends BaseValidate
{
    protected $rule = [
        'title' => 'require|unique:house_cate',
        'min_price' => 'require|<:max_price',
        'max_price' => 'require',
    ];

    protected $message = [
        'title.require' => '地區名稱不能為空',
        'title.unique' => '該地區已存在',
        'min_price.require' => '最小金額不能為空',
        'min_price' => '最小金額需小於最大金額',
        'max_price.require' => '最大金額不能為空',
    ];
}
