<?php

namespace app\task\controller;


use app\model\SpotPairModel;
use app\task\BaseController;
use think\facade\Config;
use think\facade\Log;
use xwwallet\Exchange;

class PairController extends BaseController
{
    public function lastSpotPrice()
    {
        $spotPairModel = new  SpotPairModel();
        $exchangeAPI = new Exchange(Config::get('api.exchange'));
        $pairList = $spotPairModel->getPairList();
        foreach ($pairList as $value) {
            try {
                $price = $exchangeAPI->pairPrice([
                    'base' => $value['base_code'],
                    'quote' => 'USDT'
                ]);

                $data = [
                    'id' => $value['id'],
                    'last_price' => $price['last']
                ];

                $spotPairModel->editPair($data);
            } catch (\Exception $e) {
                Log::error($e->getMessage());
                continue;
            }
        }
    }
}