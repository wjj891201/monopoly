<?php

namespace app\service;

use app\model\CurrencyChainModel;
use app\model\WalletModel;
use think\facade\Config;
use xwwallet\Wallet;

class WalletService
{

    public WalletModel $walletModel;
    private bool $all;


    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new WalletService($all);
        }
        return self::$instance;
    }


    public function __construct($all = true)
    {
        $this->walletModel = new WalletModel();
        $this->all = $all;
    }

    public function getWalletById($id)
    {
        $item = $this->walletModel->find($id);
        if (empty($item)) return [];
        return $this->handleData($item);
    }

    public function getWalletByMember($memberID, $id)
    {
        $item = $this->walletModel->getWallet(['w.member_id' => $memberID, 'w.id' => $id]);
        if (empty($item)) return [];
        return $this->handleData($item);
    }

    public function getWalletByChainId($memberId, $chainId)
    {
        $item = $this->walletModel->where([
            'member_id' => $memberId,
            'chain_id' => $chainId
        ])->find();

        if (empty($item)) return [];

        return $this->handleData($item);
    }

    public function getDefaultWallet($memberID)
    {
        $item = $this->walletModel->getDefaultWallet($memberID);

        if (empty($item)) return [];

        return $this->handleData($item);
    }

    public function setDefaultWallet($memberID, $id)
    {
        //取消所有默认
        $this->walletModel
            ->where('member_id', $memberID)
            ->update(['is_default' => 0]);

        //设置默认钱包
        $this->walletModel->editWallet([
            'id' => $id,
            'is_default' => 1
        ]);
    }


    public function getWalletList($where = [], $param = [])
    {
        $list = $this->walletModel->getWalletList($where, $param);
        foreach ($list as $key => $value) {
            $value = $this->handleData($value);
            $list[$key] = $value;
        }
        return $list;
    }

    public function getWalletCurrencyList($wallet)
    {
        if (empty($wallet)) {
            return [];
        }

        $ccModel = new CurrencyChainModel();
        $ccList = $ccModel->getCurrencyChainList([['chain_id', '=', $wallet['chain_id']]]);
        if (empty($ccList)) {
            return [];
        }
        $xwwallet = new Wallet(Config::get('api.wallet'));
        $spotService = new SpotService();
        foreach ($ccList as $key => $value) {
            if (empty($value['contract_address'])) {
                $baseResp = $xwwallet->balance([
                    'symbol' => $value['base_chain'],
                    'address' => $wallet['address']
                ]);
                $value['balance'] = $baseResp['data'][$wallet['address']];
            } else {
                $tokenResp = $xwwallet->tokenBalance([
                    'symbol' => $value['base_chain'],
                    'address' => $wallet['address'],
                    'contract_address' => $value['contract_address'],
                    'protocol' => $value['base_chain_protocol'],
                    'token_symbol' => $value['currency_code'],
                    'decimals' => $value['decimal'],
                ]);
                $value['balance'] = $tokenResp['data'][$wallet['address']];
            }
            $value['price'] = $value['balance'];
            if ($value['currency_code'] != 'USDT') {
                $price = $spotService->getPairPrice($value['currency_code']);
                $value['price'] = sprintf('%.4f', floatval($value['balance']) * floatval($price));
            }
            $ccList[$key] = $value;
        }
        return $ccList;
    }


    public function handleData($item)
    {
        if (!$this->all) {
            unset(
                $item['created_at'],
                $item['updated_at'],
                $item['password'],
                $item['is_show'],
                $item['is_delete']
            );
        }
        return $item;
    }
}
