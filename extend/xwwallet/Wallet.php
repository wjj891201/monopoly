<?php

namespace xwwallet;


class Wallet
{

    private XWGuzzle $xwGuzzle;
    private string $key = '';
    private string $secret = '';

    public function __construct($config)
    {
        if (isset($config['key'])) {
            $this->key = $config['key'];
        }

        if (isset($config['secret'])) {
            $this->secret = $config['secret'];
        }
        $this->xwGuzzle = new XWGuzzle($config);
    }


    public function appInfo()
    {
        $data = [
            'app_id' => $this->key
        ];
        $data['sign'] = $this->createSign($data);

        return $this->xwGuzzle->reqGet('/api/app/info', $data);
    }

    public function private($param)
    {
        $data = [
            'app_id' => $this->key,
            'wallet_id' => $param['wallet_id'],
            'symbol' => $param['symbol'],
            'address' => $param['address'],
            'password' => $param['password'],
        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqGet('/api/wallet/private', $data);
    }

    public function balance($param)
    {
        $data = [
            'app_id' => $this->key,
            'symbol' => $param['symbol'],
            'address' => $param['address']
        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqGet('/api/wallet/balance', $data);
    }

    public function tokenBalance($param)
    {

        $data = [
            'app_id' => $this->key,
            'symbol' => $param['symbol'],
            'address' => $param['address'],
            'contract_address' => $param['contract_address'],
            'protocol' => $param['protocol'],
            'token_symbol' => $param['token_symbol'],
            'decimals' => $param['decimals'],
        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqGet('/api/wallet/token-balance', $data);
    }

    public function createWallet($param)
    {
        $data = [
            'app_id' => $this->key,
            'username' => trim($param['name']),
            'symbol' => trim($param['symbol']),
            'password' => trim($param['password']),
        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqPost('/api/wallet/create', $data);
    }

    public function importWallet($param)
    {
        $data = [
            'app_id' => $this->key,
            'username' => trim($param['username']),
            'symbol' => trim($param['symbol']),
            'password' => trim($param['password']),
            'mnemonic' => $param['mnemonic'] ?? '',
            'private_key' => $param['private'] ?? '',
        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqPost('/api/wallet/import', $data);
    }

    public function createTokenTransfer($param)
    {
        $data = [
            'app_id' => $this->key,
            'wallet_id' => trim($param['wallet_id']),
            'from_address' => trim($param['from_address']),
            'to_address' => trim($param['to_address']),
            'password' => trim($param['password']),
            'symbol' => trim($param['symbol']),
            'amount' => floatval($param['amount']),
            'fee_rate' => floatval($param['fee_rate']),
            'contract_address' => trim($param['contract_address']),
            'protocol' => trim($param['protocol']),
            'token_symbol' => trim($param['token_symbol']),
            'decimals' => intval($param['decimals']),

        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqPost('/api/transfer/create-token', $data);
    }


    public function createTransfer($param)
    {
        $data = [
            'app_id' => $this->key,
            'wallet_id' => trim($param['wallet_id']),
            'from_address' => trim($param['from_address']),
            'to_address' => trim($param['to_address']),
            'password' => trim($param['password']),
            'symbol' => trim($param['symbol']),
            'amount' => floatval($param['amount']),
            'fee_rate' => floatval($param['fee_rate']),
        ];
        $data['sign'] = self::createSign($data);
        return $this->xwGuzzle->reqPost('/api/transfer/create', $data);
    }


    public function createSign($param): string
    {
        ksort($param);
        $queryString = http_build_query($param);
        $hash = hash_hmac('sha256', $queryString, $this->secret);
        return $hash;
    }

}