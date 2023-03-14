<?php

namespace app\api\validate;

use app\BaseValidate;

class MemberValidate extends BaseValidate
{
    protected $rule = [
        'username' => 'require|min:6|alphaNum',
        'password' => 'require|min:6',
        'confirm_password' => 'min:6|confirm:password',
        'verify_code' => 'require|checkVerifyCode',
        'email' => 'require|email',
        'email_code' => 'require',

    ];

    protected $message = [
        'username.require' => '帳號不能為空',
        'username.min' => '帳號最少6位數',
        'username.alphaNum' => '帳號只能是字母和數字',
        'password.require' => '密碼不能為空',
        'password.min' => '密碼至少要6個字元',
        'password.checkLoginPassword' => '帳號或者密碼不正確',
        'confirm_password.min' => '密碼至少要6個字元',
        'confirm_password.confirm' => '兩次密碼不一致',
        'email.require' => 'Email不能為空',
        'email.email' => 'Email格式不正确',
        'verify_code' => 'Email驗證碼不能為空',
        'verify_code.checkVerifyCode' => 'Email驗證碼不正確',
        'email_code.require' => '驗證碼不能為空',
    ];


    protected $scene = [
        'register' => ['username', 'password', 'confirm_password', 'email', 'verify_code'],
        'forget' => ['username', 'password', 'confirm_password', 'verify_code'],
        'password' => ['password', 'confirm_password', 'verify_code'],
        'email' => ['verify_code', 'email', 'email_code'],
    ];

    public function sceneLogin()
    {
        return $this->only(['username', 'password'])->append('password', 'checkLoginPassword');
    }
}
