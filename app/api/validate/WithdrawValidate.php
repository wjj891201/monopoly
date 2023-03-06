<?php

namespace app\api\validate;

use app\BaseValidate;

class WithdrawValidate extends BaseValidate
{
    protected $rule = [
        'cc_id' => 'require|checkCurrencyChain',
        'address' => 'require',
        'amount' => 'require|float',
        'password' => 'require|checkSafePassword',
        'verify_code' => 'require|checkVerifyCode',
    ];

    protected $message = [
        'cc_id' => '幣鏈信息不正確',
        'address.require' => '提現地址不能為空',
        'amount.require' => '提現金額不正確',
        'amount.float' => '數量格式不正確',
        'verify_code.require' => 'Email驗證碼不能為空',
        'verify_code.checkVerifyCode' => 'Email驗證碼不正確',
        'password' => '安全密碼不正確',
    ];

}