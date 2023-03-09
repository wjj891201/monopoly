<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\WalletModel;
use app\service\WalletService;

class WalletController extends BaseController
{
    private WalletService $walletService;

    public function initialize()
    {
        parent::initialize();
        $this->walletService = new WalletService();
        $this->setTable((new WalletModel())->getTable());
    }

    public function list()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param,[
                ['w.address|m.username', 'like', 'keywords'],
            ]);
            $list = $this->walletService->getWalletList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }
}
