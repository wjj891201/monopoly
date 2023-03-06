<?php

namespace app\api\validate;

use app\BaseValidate;

class WalletValidate extends BaseValidate
{
    protected $rule = [
        'id' => 'require',
        'cc_id'=>'require',
        'address' => 'require',
        'symbol' => 'require',
        'contract_address' => 'require',
        'protocol' => 'require',
        'token_symbol' => 'require',
        'decimals' => 'require',
        'wallet_id' => 'require',
        'password' => 'require',
        'username' => 'require',
        'type' => 'require',
        'name' => 'require',
        'to_address'=>'require',
        'amount'=>'require|float'
    ];

    protected $message = [
        'address.require' => '地址不能為空',
        'cc_id.require' => '幣鏈信息不存在',
        'symbol.require' => '資產不能為空',
        'contract_address.require' => '合約地址不能為空',
        'protocol.require' => '協議不能為空',
        'token_symbol.require' => '代幣標識符不能為空',
        'decimals.require' => '小數位不能為空',
        'wallet_id.require' => '錢包ID不能為空',
        'password.require' => '密碼不能為空',
        'username.require' => '用戶名稱不能為空',
        'type.require' => '導入類型不能為空',
        'id.require' => '錢包不存在',
        'name.require' => '錢包名稱不能為空',
        'amount.require' => '轉帳數量不能為空',
        'amount.float'=>'數量必須是數字'
    ];

    protected $scene = [
        'id' => ['id'],
        'balance' => ['id','cc_id'],
        'token_balance' => ['address', 'symbol', 'contract_address', 'protocol', 'token_symbol', 'decimals'],
        'private' => ['id', 'password'],
        'create' => ['name', 'symbol', 'password'],
        'import' => ['name', 'symbol', 'password', 'type'],
        'delete' => ['id', 'password'],
        'name' => ['id', 'name'],
        'transfer' => ['id', 'to_address','amount', 'password','cc_id'],
        'transaction'=>['id','cc_id']
    ];
}