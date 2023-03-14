<?php

namespace app\api\validate;

use app\BaseValidate;

class TransferValidate extends BaseValidate
{
    protected $rule = [
        'currency_id' => 'require|checkCurrency',
        'from_asset_type' => 'require',
        'to_asset_type' => 'require',
        'amount' => 'require|float',
    ];

    protected $message = [
        'currency_id' => '貨幣不正確',
        'from_asset_type.require' => '來源帳戶類型不正確',
        'to_asset_type.require' => '收款帳戶類型不正確',
        'amount' => '數量不正確',
    ];
}