<?php

namespace app\api\controller;

use app\api\validate\WalletValidate;
use app\exception\RespException;
use app\model\WalletTransactionModel;
use app\service\CCService;
use app\service\WalletService;
use think\facade\Config;
use think\facade\Log;
use think\facade\Request;
use xwaddress\AddressFactory;
use xwscanner\Scanner;
use xwwallet\Wallet;

class WalletController extends CommonController
{
    protected WalletService $walletService;
    protected CCService $CCService;

    public function initialize()
    {
        parent::initialize();
        $this->walletService = new WalletService(false);
        $this->CCService = new CCService(false);
    }


    public function list()
    {
        $param = get_param();
        $where = [
            ['is_delete', '=', 0],
            ['member_id', '=', JWT_UID]
        ];
        if (!empty($param['chain_id'])) {
            $where[] = ['chain_id', '=', $param['chain_id']];
        }
        $list = $this->walletService->getWalletList($where, $param);
        if (count($list) == 0) {
            return $this->apiError('數據不存在');
        }
        return $this->apiData($list);
    }


    public function info()
    {
        try {
            $id = intval(get_param('id'));
            $resp = [];
            if ($id) {
                $item = $this->walletService->getWalletById($id);
            } else {
                $item = $this->walletService->getDefaultWallet(JWT_UID);
            }
            if ($item['is_delete'] == 1 || $item['member_id'] != JWT_UID) {
                return $this->apiError('參數不正確');
            }

            //钱包的cc数据
            $ccItem = $this->CCService->getCurrencyChainByChainID($item['chain_id']);

            $item['cc_id'] = $ccItem['id'];
            $resp['info'] = $item;
            $totalPrice = 0;
            $isDetail = get_param('is_detail');
            if (!empty($isDetail)) {
                $ccList = $this->walletService->getWalletCurrencyList($item);
                foreach ($ccList as $key => $value) {
                    $totalPrice = $totalPrice + $value['price'];
                }
                $resp['list'] = $ccList;
            }
            $resp['total_price'] = $totalPrice;
            return $this->apiData($resp);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    //驗證錢包密碼
    public function checkPassword()
    {
        try {
            $id = get_param('id');
            $password = get_param('password');
            if (empty($id) || empty($password)) {
                return $this->apiError('參數不正確');
            }

            $id = intval($id);
            $password = create_password($password);

            $item = (new WalletService())->getWalletByMember(JWT_UID, $id);
            if (empty($item) || $item['is_delete'] == 1) {
                return $this->apiError('參數不正確');
            }

            if ($item['password'] != $password) {
                return $this->apiError('錢包密碼錯誤');
            }

            return $this->apiSuccess('驗證通過');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function create()
    {
        $param = get_param();
        try {

            $clientID = Request::header('X-Client-ID');
            $chainID = $param['chain_id'] ?? 0;
            $chainItem = $this->CCService->getChainById($chainID);
            $param["symbol"] = $chainItem['base_chain'];
            validate(WalletValidate::class)->scene('create')->check($param);

            $xwwallet = new Wallet(Config::get('api.wallet'));
            $resp = $xwwallet->createWallet($param);

            $data = [
                'member_id' => JWT_UID,
                "client_id" => $clientID,
                "name" => $param['name'],
                "password" => create_password($param['password']),
                "password_tip" => $param['password_tip'],
                "chain_id" => $param['chain_id'],
                "wallet_id" => $resp['data']['wallet_id'],
                "address" => $resp['data']['address'],
                "is_default" => 1,
                "has_mnemonic" => 0,
            ];

            $id = $this->walletService->walletModel->addWallet($data);
            if ($id) {
                $this->walletService->setDefaultWallet(JWT_UID, $id);
            }

            //導入掃描器
            try {
                $xwscanner = new Scanner(Config::get('api.scanner'));
                $xwscanner->importAddress(['symbol' => $chainItem['base_chain'], 'address' => $resp['data']['address']]);
            } catch (\Exception $e) {
                Log::error($e->getMessage());
            }


            $data['id'] = $id;
            unset($data['password'], $data['password_tip']);
            add_user_log('add', '錢包', $id, $data);
            return $this->apiData($data);

        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return $this->apiError($e->getMessage());
        }
    }

    public function import()
    {
        $param = get_param();
        try {
            $clientID = Request::header('X-Client-ID');
            $chainID = $param['chain_id'] ?? 0;
            $chainItem = $this->CCService->getChainById($chainID);
            $param["symbol"] = $chainItem['base_chain'];
            validate(WalletValidate::class)->scene('import')->check($param);

            if (!isset($param['mnemonic']) && $param['type'] == 'mnemonic') {
                return $this->apiError('助記詞不能為空');
            }

            if (!isset($param['private']) && $param['type'] == 'private') {
                return $this->apiError('私鑰不能為空');
            }

            //導入錢包
            $xwwallet = new Wallet(Config::get('api.wallet'));
            $resp = $xwwallet->importWallet($param);
            $data = [
                'member_id' => JWT_UID,
                "client_id" => $clientID,
                "name" => $param['name'],
                "password" => create_password($param['password']),
                "password_tip" => $param['password_tip'],
                "chain_id" => $param['chain_id'],
                "wallet_id" => $resp['data']['wallet_id'],
                "address" => $resp['data']['address'],
                "is_default" => 1,
                "has_mnemonic" => 0,
            ];
            $id = $this->walletService->walletModel->addWallet($data);
            if ($id) {
                $this->walletService->setDefaultWallet(JWT_UID, $id);
            }

            //導入掃描器
            try {
                $xwscanner = new Scanner(Config::get('api.scanner'));
                $xwscanner->importAddress(['symbol' => $chainItem['base_chain'], 'address' => $resp['data']['address']]);
            } catch (\Exception $e) {
                Log::error($e->getMessage());
            }


            $data['id'] = $id;
            unset($data['password'], $data['password_tip']);
            add_user_log('add', '錢包', $id, $data);
            return $this->apiData($resp['data']);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return $this->apiError($e->getMessage());
        }
    }

    public function private()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('private')->check($param);
            $xwwallet = new Wallet(Config::get('api.wallet'));


            $password = create_password($param['password']);

            $item = (new WalletService())->getWalletByMember(JWT_UID, $param['id']);
            if (empty($item) || $item['is_delete'] == 1) {
                return $this->apiError('參數不正確');
            }

            if ($item['password'] != $password) {
                return $this->apiError('錢包密碼錯誤');
            }

            $resp = $xwwallet->private([
                'wallet_id' => $item['wallet_id'],
                'symbol' => $item['base_chain'],
                'address' => $item['address'],
                'password' => $param['password'],
            ]);
            return $this->apiData($resp['data']);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return $this->apiError($e->getMessage());
        }
    }

    public function balance()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('balance')->check($param);
            $item = $this->walletService->getWalletByMember(JWT_UID, $param['id']);
            if ($item['is_delete'] == 1) {
                return $this->apiError('參數不正確');
            }
            //幣鏈
            $xwwallet = new Wallet(Config::get('api.wallet'));
            $ccItem = $this->CCService->getCurrencyChainByID($param['cc_id']);

            if (empty($ccItem['contract_address'])) {
                $resp = $xwwallet->balance([
                    'symbol' => $item['base_chain'],
                    'address' => $item['address']
                ]);
            } else {
                $resp = $xwwallet->tokenBalance([
                    'symbol' => $ccItem['base_chain'],
                    'address' => $item['address'],
                    'contract_address' => $ccItem['contract_address'],
                    'protocol' => $ccItem['base_chain_protocol'],
                    'token_symbol' => $ccItem['currency_code'],
                    'decimals' => $ccItem['decimal'],
                ]);
            }
            $item['balance'] = $resp['data'][$item['address']];
            $item['currency_code'] = $ccItem['currency_code'];
            return $this->apiData($item);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function eye()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('id')->check($param);
            $item = $this->walletService->getWalletByMember(JWT_UID, $param['id']);
            if ($item['is_delete'] == 1) {
                return $this->apiError('參數不正確');
            }
            $eye = $item['eye'] == 'close' ? 'open' : 'close';

            $this->walletService->walletModel->editWallet([
                'id' => $param['id'],
                'eye' => $eye
            ]);
            return $this->apiSuccess();
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }


    }

    public function name()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('name')->check($param);
            $item = $this->walletService->getWalletByMember(JWT_UID, $param['id']);

            if ($item['is_delete'] == 1) {
                return $this->apiError('參數不正確');
            }

            $this->walletService->walletModel->editWallet([
                'id' => $param['id'],
                'name' => trim($param['name'])
            ]);
            return $this->apiSuccess();
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function default()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('id')->check($param);

            $item = $this->walletService->getWalletById($param['id']);
            if ($item['member_id'] != JWT_UID) {
                return $this->apiError('參數不正確');
            }

            $this->walletService->setDefaultWallet(JWT_UID, $param['id']);

            return $this->apiSuccess();
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }


    }

    //转账（代币+主币）
    public function transfer()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('transfer')->check($param);

            $item = $this->walletService->getWalletById($param['id']);
            if ($item['member_id'] != JWT_UID) {
                return $this->apiError('參數不正確');
            }

            $ccItem = $this->CCService->getCurrencyChainByID($param['cc_id']);

            //验证地址格式
            $address = AddressFactory::create($ccItem['base_chain'], $ccItem['base_chain_protocol'], $param['to_address']);
            if (!$address->isValid()) {
                throw new RespException(1, '收款地址格式不正確');
            }
            //幣鏈
            $xwwallet = new Wallet(Config::get('api.wallet'));
            if (empty($ccItem['contract_address'])) {
                $resp = $xwwallet->createTransfer([
                    'wallet_id' => $item['wallet_id'],
                    'from_address' => $item['address'],
                    'to_address' => $param['to_address'],
                    'password' => $param['password'],
                    'symbol' => $ccItem['base_chain'],
                    'amount' => $param['amount'],
                    'fee_rate' => 1.5,
                ]);
            } else {
                $resp = $xwwallet->createTokenTransfer([
                    'wallet_id' => $item['wallet_id'],
                    'from_address' => $item['address'],
                    'to_address' => $param['to_address'],
                    'password' => $param['password'],
                    'symbol' => $ccItem['base_chain'],
                    'amount' => $param['amount'],
                    'fee_rate' => 1.5,
                    'contract_address' => $ccItem['contract_address'],
                    'protocol' => $ccItem['base_chain_protocol'],
                    'token_symbol' => $ccItem['currency_code'],
                    'decimals' => $ccItem['decimal'],
                ]);
            }
            return $this->apiSuccess('轉賬成功', $resp['data']);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }


    //钱包地址交易明细
    public function transactionList()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('transaction')->check($param);

            $item = $this->walletService->getWalletByMember(JWT_UID, $param['id']);
            if (empty($item)) {
                return $this->apiError('參數不正確');
            }
            $ccItem = $this->CCService->getCurrencyChainByID($param['cc_id']);

            $where = [
                ['symbol', '=', $ccItem['base_chain']],
                ['contract_address', '=', $ccItem['contract_address']]
            ];

            if (!empty($param['type']) && $param['type'] == 1) {
                $where[] = ['from_address', '=', $item['address']];
            } elseif (!empty($param['type']) && $param['type'] == 2) {
                $where[] = ['to_address', '=', $item['address']];
            } else {
                $where[] = ['to_address|from_address', '=', $item['address']];
            }
            $list = (new WalletTransactionModel())->getTransactionList($where, $param);

            foreach ($list as $key=>$value){
                if ($value['is_contract'] == 1){
                    $amount = floatval($value['amount']) /pow(10,$ccItem['decimal']);
                    $value['amount'] = round($amount,$ccItem['currency_decimal']);
                }
                $list[$key] = $value;
            }

            return $this->apiData($list);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function delete()
    {
        $param = get_param();
        try {
            validate(WalletValidate::class)->scene('delete')->check($param);
            $item = $this->walletService->getWalletByMember(JWT_UID, $param['id']);


            if ($item['password'] != create_password($param['password'])) {
                return $this->apiError('錢包密碼錯誤');
            }

            $this->walletService->walletModel->editWallet([
                'id' => $param['id'],
                'is_delete' => 1,
            ]);
            return $this->apiSuccess();
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }


    }

}