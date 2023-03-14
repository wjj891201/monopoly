<?php

namespace app\api\controller;

use app\api\validate\WithdrawValidate;
use app\exception\RespException;
use app\facade\MutexFacade;
use app\model\AccountWithdrawModel;
use app\service\AccountService;
use app\service\CCService;
use app\service\WithdrawService;
use think\facade\Config;

class WithdrawController extends CommonController
{
    protected WithdrawService $withdrawService;
    protected AccountService $accountService;

    public function initialize()
    {
        parent::initialize();
        $this->withdrawService = new WithdrawService();
        $this->accountService = new AccountService();
    }

    public function list()
    {
        $param = get_param();
        $where[] = ['w.member_id', '=', JWT_UID];
        $list = $this->withdrawService->getWithdrawList($where, $param);
        return $this->apiData($list);
    }

    public function submit()
    {
        $param = get_param();
        try {
            $member = $this->memberModel->find(JWT_UID);
            $param['email'] = $member['email'];
            $param['member_id'] = JWT_UID;
            validate(WithdrawValidate::class)->check($param);

            $ccItem = (new CCService())->getCurrencyChainByID($param["cc_id"]);
            if (empty($ccItem)){
                throw new RespException(1,'幣鏈數據不存在');
            }

            $account = $this->accountService->getAccountByMemberID(JWT_UID, $ccItem['currency_id'], 'funding');
            if (empty($account)) {
                throw new RespException(1,'資產帳戶不存在');
            }

            $mutex = MutexFacade::create("account_change");
            if ($mutex->acquireLock(Config::get('mutex.timeout'))) {
                $param["member_id"] = JWT_UID;
                //保存提現
                $id = (new AccountWithdrawModel())->addWithdraw($param);
                add_user_log("add", "提現", JWT_UID, $param);

                $this->accountService->subFundingAvailable();

                $this->accountService->updateAccount([
                    'member_id' => $account['member_id'],
                    'scene' => 'withdraw',
                    'asset_type' => 'funding',
                    'balance_type' => 'available',
                    'operate_type' => 'sub',
                    'currency_id' => $account['currency_id'],
                    'amount' => $param['amount'],
                    'item_id' => $id,
                ]);
                add_user_log('edit', "提現", $id, $param);
                $mutex->releaseLock();
            }
            return $this->apiSuccess();
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}