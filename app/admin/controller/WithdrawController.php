<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\AccountWithdrawModel;
use app\model\ChainModel;
use app\model\CurrencyChainModel;
use app\model\CurrencyModel;
use app\service\WithdrawService;
use Carbon\Carbon;
use think\facade\View;

class WithdrawController extends BaseController
{

    private WithdrawService $withdrawService;

    public function initialize()
    {
        parent::initialize();
        $this->withdrawService = new WithdrawService();
        $this->setTable((new AccountWithdrawModel())->getTable());
    }

    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param,[
                ['m.username', 'like', 'keywords'],
            ]);
            $list = $this->withdrawService->getWithdrawList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

    public function initForm($item)
    {
        $cc_model = new CurrencyChainModel();
        $cc_item = $cc_model->find($item['cc_id']);
        View::assign('cc_item', $cc_item);

        $chain_model = new ChainModel();
        $chain_item = $chain_model->find($cc_item['chain_id']);
        View::assign('chain_item', $chain_item);

        $currency_model = new CurrencyModel();
        $currency_item = $currency_model->find($cc_item['currency_id']);
        View::assign('currency_item', $currency_item);
    }

    public function save($param)
    {
        switch ($param['status']){
            case 'finished':
                $param['finished_at'] = Carbon::now()->toDateTimeString();
                break;
            case 'refused':
                $param['refused_at'] = Carbon::now()->toDateTimeString();
                break;
            case 'checked':
                $param['checked_at'] = Carbon::now()->toDateTimeString();
                break;
        }
        return parent::save($param);
    }
}
