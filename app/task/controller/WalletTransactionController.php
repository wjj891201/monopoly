<?php

namespace app\task\controller;

use app\exception\RespException;
use app\task\BaseController;
use think\facade\Db;
use think\facade\Log;

class WalletTransactionController extends BaseController
{
    public function import()
    {
        try {
            $param = get_param();
            if (empty($param) || empty($param['from_address']) || empty($param['to_address'])) {
                throw new RespException(1,'參數錯誤');
            }
            $fromAddress = explode(':',$param['from_address']);
            $toAddress = explode(':',$param['to_address']);
            $param['from_address'] = $fromAddress[0];
            $param['to_address'] = $toAddress[0];
            if (count($fromAddress) == 2){
                $param['amount'] = $fromAddress[1];
            }
            Db::name('wallet_transaction')->strict(false)->insert($param);
        } catch (\Exception $e) {
            Log::error($e->getMessage());
            return $this->apiError($e->getMessage());
        }
    }

}