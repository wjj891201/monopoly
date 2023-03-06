<?php

namespace app\api\validate;

use think\Validate;

class RegisterValidate extends Validate
{
    protected $rule = [
        'username' => 'require|min:6|alphaNum',
        'password' => 'require|min:6|confirm:confirm_password',
        'confirm_password' => 'min:6|confirm:password',
        'email' => 'require|email',
        'verify_code' => 'require',
    ];

    protected $message = [
        'username.require' => '帳號不能為空',
        'username.min' => '帳號最少6位數',
        'username.alphaNum' => '帳號只能是字母+數字',
        'password.require' => '密碼不能為空',
        'password.min' => '密碼至少要6個字元',
        'password.confirm' => '兩次密碼不一致1',
        'confirm_password.min' => '密碼至少要6個字元',
        'confirm_password.confirm' => '兩次密碼不一致2',
        'email.require' => 'Email不能為空',
        'email.email' => 'Email格式不正确',
        'verify_code.require' => 'Email驗證碼不能為空',
    ];
}