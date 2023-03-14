<?php

namespace app\api\validate;

use app\BaseValidate;

class WalletValidate extends BaseValidate
{
    protected $rule = [
        'member_id' => 'require',
        'cc_id' => 'require',
    ];

    protected $message = [
        'member_id.require' => '用戶不存在',
        'cc_id.require' => '幣鏈信息不存在',
    ];

}