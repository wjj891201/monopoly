<?php

namespace app\store\validate;

use think\Validate;

class StoreValidate extends Validate
{
    protected $rule = [
        'cate_id' => 'require',
        'title' => 'require',
        'content' => 'require',
    ];

    protected $message = [
        'cate_id.require' => '所屬分類不能為空',
        'title.require' => '文章標題不能為空',
        'content.require' => '文章內容不能為空',
    ];
}