<?php

namespace app\admin\validate;

use think\Validate;

class CurrencyChainValidate extends Validate
{
    protected $rule = [
        'chain_id' => 'require',
        'currency_id' => 'require',
        'chain_precision' => 'require',
        'display_name' => 'require',
        'min_recharge_amount' => 'require',
        'min_withdraw_amount' => 'require',
        'max_withdraw_amount' => 'require',

    ];

    protected $message = [
        'chain_id.require' => '請選擇公鏈',
        'currency_id.require' => '請選擇貨幣',
        'chain_precision.require' => '幣鏈小數位不能為空',
        'display_name.require' => '顯示名稱不能為空',
        'min_recharge_amount.require' => '最小充幣金額不能為空',
        'min_withdraw_amount.require' => '最小提幣金額不能為空',
        'max_withdraw_amount.require' => '最大提幣金額不能為空',
    ];
}