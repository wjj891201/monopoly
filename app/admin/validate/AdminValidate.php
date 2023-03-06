<?php


namespace app\admin\validate;

use think\Validate;

class AdminValidate extends Validate
{
    protected $regex = ['checkUser' => '/^[A-Za-z]{1}[A-Za-z0-9_-]{4,19}$/'];

    protected $rule = [
        'username' => 'require|regex:checkUser|unique:admin',
        'password' => 'min:6',
        'nickname' => 'require',
        'role_id' => 'require',
        'id' => 'require',
    ];

    protected $message = [
        'username.require' => '登錄帳號不能為空',
        'username.unique' => '同樣的登錄帳號已經存在',
        'nickname.require' => '昵稱不能為空',
        'role_id.require' => '至少要選擇一個用戶角色',
        'id.require' => '缺少更新條件',
    ];

    protected $scene = [
        'add' => ['nickname', 'role_id', 'password', 'username', 'status'],
        'edit' => ['nickname', 'role_id', 'username', 'status'],
        'editPersonal' => ['nickname'],
        'editpwd' => ['password'],
    ];

    // 自定義驗證規則
    protected function checkStatus($value, $rule, $data)
    {
        if ($value == -1 and $data['id'] == 1) {
            return $rule == false;
        }
        return $rule == true;
    }
}
