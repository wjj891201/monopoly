<?php


namespace app\admin\validate;

use think\Validate;

class RoleValidate extends Validate
{
    protected $rule = [
        'name' => 'require|unique:member_role',
    ];

    protected $message = [
        'name.require' => '等級名稱不能為空',
        'name.unique' => '同樣的等級名稱已經存在',
    ];
}
