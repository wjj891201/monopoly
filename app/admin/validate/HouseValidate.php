<?php


namespace app\admin\validate;

use think\Validate;

class HouseValidate extends BaseValidate
{
    protected $rule = [
        'cate_id' => 'require',
        'title' => 'require',
        'status' => 'require'
    ];

    protected $message = [
        'cate_id.require' => '所屬分類不能為空',
        'title.require' => '文章標題不能為空',
        'status.require' => '請選擇狀態',
    ];
}
