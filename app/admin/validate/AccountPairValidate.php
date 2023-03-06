<?php

namespace app\admin\validate;

use app\BaseValidate;

class AccountPairValidate extends BaseValidate
{
    protected $rule = [
        'cc_id' => 'require',
        'name' => 'require',
        'collect_address' => 'require',
        'fee_address' => 'require',
    ];

    protected $message = [
        'cc_id.require' => '幣鏈不能為空',
        'name.require' => '名稱不能為空',
        'collect_address.require' => '歸集地址不能為空',
        'fee_address.require' => '出金地址不能為空',
    ];

}