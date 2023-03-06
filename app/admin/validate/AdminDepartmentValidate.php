<?php


namespace app\admin\validate;

use think\Validate;

class AdminDepartmentValidate extends Validate
{
    protected $rule = [
        'title' => 'require',
        'id' => 'require',
    ];

    protected $message = [
        'title.require' => '部門名稱不能為空',
        'id.require' => '缺少更新條件',
    ];

    protected $scene = [
        'add' => ['title'],
        'edit' => ['id', 'title'],
    ];
}
