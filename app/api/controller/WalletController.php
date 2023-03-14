<?php

namespace app\api\controller;

use app\api\validate\WalletValidate;
use app\model\MemberModel;
use app\service\CCService;
use app\service\MemberService;
use app\service\WalletService;
use think\facade\Config;
use think\facade\Log;
use think\facade\Request;
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


    public function info()
    {
        $param = get_param();

        $chainID = $param['chain_id'] ?? 0;

        $wallet = $this->walletService->getWalletByChainId(JWT_UID, $chainID);
        if (empty($wallet)) {
            return $this->apiError('錢包不存在');
        }
        return $this->apiData(['address' => $wallet['address']]);
    }

    public function create()
    {
        $param = get_param();
        try {
            $clientID = Request::header('X-Client-ID') ?? '';
            $chainID = $param['chain_id'] ?? 0;
            $chainItem = $this->CCService->getChainById($chainID);
            if (empty($chainItem)) {
                return $this->apiError('公鏈不存在');
            }
            $wallet = $this->walletService->getWalletByChainId(JWT_UID, $chainID);
            if ($wallet) {
                return $this->apiError('錢包已存在');
            }


            $member = MemberService::getInstance()->getMemberById(JWT_UID);
            $xwwallet = new Wallet(Config::get('api.wallet'));
            $resp = $xwwallet->createWallet([
                'name' => $member['username'],
                'symbol' => $chainItem['base_chain'],
                'password' => 'xw123456',
            ]);

            $data = [
                'member_id' => JWT_UID,
                "client_id" => $clientID,
                "name" => $member['username'],
                "chain_id" => $chainID,
                "wallet_id" => $resp['data']['wallet_id'],
                "address" => $resp['data']['address'],
            ];

            $id = $this->walletService->walletModel->addWallet($data);

            //導入掃描器
            try {
                $xwscanner = new Scanner(Config::get('api.scanner'));
                $xwscanner->importAddress(['symbol' => $chainItem['base_chain'], 'address' => $resp['data']['address']]);
            } catch (\Exception $e) {
                Log::error($e->getMessage());
            }
            $data['id'] = $id;
            add_user_log('add', '錢包', $id, $data);
            return $this->apiData($data);

        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return $this->apiError($e->getMessage());
        }
    }
}