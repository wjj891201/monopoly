<?php

namespace app\api\validate;

use app\facade\CaptchaFacade;
use think\Validate;

class VerifyCodeValidate extends Validate
{
    protected $rule = [
        'email'=>'require',
        'client_id' => 'require',
        'captcha' => 'require|checkCaptcha',
    ];

    protected $message = [
        'email.require' => 'Email不能為空',
        'client_id.require' => '客戶端未識別',
        'captcha.require' => '圖形驗證碼不能為空',
        'captcha.checkCaptcha' => '圖形驗證碼不正確',
    ];

    protected $scene = [
        "member_send"=>["email"],
        "captcha_send"=>["client_id","captcha"]
    ];

    // 自定義驗證規則
    protected function checkCaptcha($value, $rule, $data = [])
    {
        if (CaptchaFacade::check($value,$data['client_id'])) {
            return true;
        }
        return false;
    }
}