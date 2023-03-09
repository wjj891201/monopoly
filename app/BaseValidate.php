<?php

namespace app;

use app\facade\VerifyCodeFacade;
use app\service\MemberService;
use think\facade\Config;
use think\facade\Db;
use think\Validate;

class BaseValidate extends Validate
{

    //驗證用戶名稱
    protected function checkUsername($value, $rule, $data = [])
    {
        $id = Db::name('member')->where('username', $data['username'])->value('id');
        return !empty($id);
    }

    //驗證email驗證碼
    protected function checkVerifyCode($value, $rule, $data = [])
    {
        return (new MemberService())->checkCode($data["email"], $value);
    }

    //驗證登入密碼
    protected function checkLoginPassword($value, $rule, $data = [])
    {
        $password = Db::name('member')->where('id', $data['member_id'])->value('password');
        return $password == create_password($value);
    }

    //驗證安全密碼
    protected function checkSafePassword($value, $rule, $data = [])
    {
        $password = Db::name('member')->where('id', $data['member_id'])->value('safe_password');
        return $password == create_password($value);
    }

    protected function checkAssetType($value, $rule, $data = [])
    {
        $assetList = Config::get('account.asset_types');
        return in_array($value, $assetList);
    }

    //驗證貨幣是否存在
    protected function checkCurrency($value, $rule, $data = [])
    {
        $item = Db::name("currency")->field("id")->where("id", $value)->find();
        return !empty($item);
    }

    //驗證幣鏈是否存在
    protected function checkCurrencyChain($value, $rule, $data = [])
    {
        $item = Db::name("currency_chain")->field("id")->where("id", $value)->find();
        return !empty($item);
    }

    protected function checkStatus($value, $rule, $data = [])
    {
        $status = Db::name($data['table'])->where('id', $data['id'])->value('status');
        return $status == 1;
    }

}