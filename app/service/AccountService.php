<?php

namespace app\service;


use app\exception\RespException;
use app\model\AccountLogModel;
use app\model\AccountModel;
use app\model\CurrencyModel;
use app\validate\AccountValidate;

class AccountService
{
    public AccountModel $accountModel;
    public CurrencyModel $currencyModel;
    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new AccountService($all);
        }
        return self::$instance;
    }

    public function __construct()
    {
        $this->accountModel = new AccountModel();
        $this->currencyModel = new CurrencyModel();
    }


    public function assetType($type)
    {
        if ($type == 'funding') {
            return '資金帳戶';
        } else if ($type == 'spot') {
            return '幣幣帳戶';
        } else if ($type == 'swap') {
            return '合約帳戶';
        } else if ($type == 'otc') {
            return 'OTC';
        }
        return $type;
    }

    public function getAccountById($id)
    {
        $item = $this->accountModel->find($id);
        if (empty($item)) return [];
        $item['asset_name'] = $this->assetType($item['asset_type']);
        return $item;
    }

    public function getAccountList($where, $param = [])
    {
        $result = $this->accountModel->getAccountList($where, $param);
        foreach ($result as $key => $value) {
            $result[$key] = $this->handleAccount($value);
        }
        return $result;
    }


    public function getAccountByMemberID($member_id, $currency_id, $asset_type)
    {
        $item = $this->accountModel->where([
            'member_id' => $member_id,
            'currency_id' => $currency_id,
            'asset_type' => $asset_type
        ])->find();

        if (empty($item)) return [];

        $item['hold'] = $item['available'] + $item['freeze'];
        return $item;
    }


    public function createEmptyAccount($member_id, $currency_id, $asset_type)
    {
        $currency = $this->currencyModel->find($currency_id);
        $account = $this->getAccountByMemberID($member_id, $currency_id, $asset_type);
        $data = [];
        if (empty($account)) {
            $data = array(
                'member_id' => $member_id,
                'currency_id' => $currency_id,
                'currency_code' => $currency['code'],
                'asset_type' => $asset_type,
            );
            $data['id'] = $this->accountModel->createAccount($data);
        }
        return $data;
    }


    public function updateAccount($param)
    {
        try {
            (new AccountValidate())->check($param);

            validate(AccountValidate::class)->check($param);

            $currency = $this->currencyModel->find($param['currency_id']);
            if (!$currency) {
                throw new RespException(1, '貨幣不存在');
            }

            $account = $this->getAccountByMemberID($param['member_id'], $param['currency_id'], $param['asset_type']);

            if (empty($account)) {
                throw new RespException(1, '資產帳戶不存在');
            }

            $before = $account[$param['balance_type']];
            $after = 0;

            if ($param['operate_type'] == 'add') {
                $after = $account[$param['balance_type']] + $param['amount'];
            } elseif ($param['operate_type'] == 'sub') {
                if ($account[$param['balance_type']] < $param['amount']) {
                    throw new RespException(1, $param['balance_type'] . '帳戶餘額不足');
                }
                $after = $account[$param['balance_type']] - $param['amount'];
            }

            $accountData = array(
                'id' => $account['id'],
                $param['balance_type'] => $after
            );

            $this->accountModel->updateAccount($accountData);


            $param['currency_code'] = $currency['code'];
            $param['before_amount'] = $before;
            $param['after_amount'] = $after;

            (new AccountLogModel())->createLog($param);

            return true;
        } catch (\Exception $e) {
            throw new RespException(1, $e->getMessage());
        }
    }

    public function checkAccount($param)
    {
        $account = $this->getAccountByMemberID($param['member_id'], $param['currency_id'], $param['asset_type']);
        if (empty($account)) {
            throw new RespException(1, '資產帳戶不存在');
        }
        if ($account[$param['balance_type']] < $param['amount']) {
            throw new RespException(1, '帳戶餘額不足');
        }
        return true;
    }


    public function handleAccount($account)
    {
        $account['asset_name'] = $this->assetType($account['asset_type']);
        $account['hold'] = $account['available'] + $account['freeze'];
        $pairPrice = (new SpotService())->getPairPrice($account['currency_code'], 'USDT');
        $account['hold_price'] = sprintf('%.2f', $account['hold'] * $pairPrice);
        $account['available_price'] = sprintf('%.2f', $account['available'] * $pairPrice);
        $account['freeze_price'] = sprintf('%.2f', $account['freeze'] * $pairPrice);
        $account['available'] = round($account['available'], $account['decimal']);
        return $account;
    }


    //减少币币可用帐户
    public function subFundingAvailable($memberID, $currencyID, $amount, $itemID = 0, $remark = '')
    {
        return $this->updateAccount([
            'member_id' => $memberID,
            'scene' => 'funding',
            'asset_type' => 'funding',
            'balance_type' => 'available',
            'operate_type' => 'sub',
            'currency_id' => $currencyID,
            'amount' => $amount,
            'item_id' => $itemID,
            'remark' => $remark
        ]);
    }

    //增加币币可用帐户
    public function addFundingAvailable($memberID, $currencyID, $amount, $itemID = 0, $remark = '')
    {
        return $this->updateAccount([
            'member_id' => $memberID,
            'scene' => 'funding',
            'asset_type' => 'funding',
            'balance_type' => 'available',
            'operate_type' => 'add',
            'currency_id' => $currencyID,
            'amount' => $amount,
            'item_id' => $itemID,
            'remark' => $remark
        ]);
    }
}
