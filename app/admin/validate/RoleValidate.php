<?php


namespace app\admin\validate;

use think\Validate;

class RoleValidate extends Validate
{
    protected $rule = [
        'name' => 'require|unique:member_role',
        'accumulate' => 'require',
        'maintenance' => 'require',
        'dice_num' => 'require',
        'layer_num' => 'require',
    ];

    protected $message = [
        'name.require' => '等級名稱不能為空',
        'name.unique' => '同樣的等級名稱已經存在',
        'accumulate.require' => '累積經驗值不能為空',
        'maintenance.require' => '等級維護不能為空',
        'dice_num.require' => '每日骰寶數不能為空',
        'layer_num.require' => '代數不能為空',
    ];
}
