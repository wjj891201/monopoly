<?php

namespace app\validate;

use app\BaseValidate;

class AccountValidate extends BaseValidate
{
    protected $rule = [
        'member_id' => 'require',
        'asset_type' => 'require|checkAssetType',
        'balance_type' => 'require|in:available,freeze',
        'operate_type' => 'require|in:add,sub',
        'currency_id' => 'require|integer',
        'amount' => 'require|float',
        'scene' => 'require',

    ];

    protected $message = [
        'member_id.require' => '用戶不存在',
        'asset_type' => '資產類型不正確',
        'balance_type.require' => '餘額類型不正確',
        'operate_type.require' => '操作類型不正確',
        'currency_id.require' => '資產不存在',
        'amount.require' => '數量不能為空',
        'amount.float' => '數量格式不正確',
        'scene.require' => '場景不能為空',
    ];

    protected $scene = [
        'update' => ['member_id', 'asset_type', 'balance_type', 'operate_type', 'currency_id', 'amount', 'scene'],
    ];


}