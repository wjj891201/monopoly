<?php

namespace app\api\controller;

use app\api\validate\TransferValidate;
use app\facade\MutexFacade;
use app\model\AccountTransferModel;
use app\service\AccountService;
use think\facade\Config;
use think\facade\Db;

class TransferController extends CommonController
{
    protected AccountTransferModel $transferModel;
    protected AccountService $accountService;

    public function initialize()
    {
        parent::initialize();
        $this->transferModel = new AccountTransferModel();
        $this->accountService = new AccountService();
    }

    public function list()
    {
        $param = get_param();
        try {
            $where[] = ['w.member_id', '=', JWT_UID];
            $list = $this->transferModel->getTransferList($where, $param);
            return $this->apiData($list);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function submit()
    {
        $param = get_param();
        $mutex = MutexFacade::create("account_change");
        Db::startTrans();
        try {
            validate(TransferValidate::class)->check($param);
            if ($mutex->acquireLock(Config::get('mutex.timeout'))) {
                $param["member_id"] = JWT_UID;

                $data = [
                    'from_member' => JWT_UID,
                    'to_member' => JWT_UID,
                    'from_asset_type' => $param['from_asset_type'],
                    'to_asset_type' => $param['to_asset_type'],
                    'from_balance_type' => 'available',
                    'to_balance_type' => 'available',
                    'currency_id' => $param['currency_id'],
                    'amount' => $param['amount'],
                ];

                $id = $this->transferModel->addTransfer($data);
                add_user_log("add", "劃轉", $id, $param);
                $this->accountService->updateAccount([
                    'member_id' => JWT_UID,
                    'scene' => 'transfer',
                    'asset_type' => $param["from_asset_type"],
                    'balance_type' => 'available',
                    'operate_type' => 'sub',
                    'currency_id' => $param['currency_id'],
                    'amount' => $param['amount'],
                    'item_id' => $id,
                ]);
                $this->accountService->updateAccount([
                    'member_id' => JWT_UID,
                    'scene' => 'transfer',
                    'asset_type' => $param["to_asset_type"],
                    'balance_type' => 'available',
                    'operate_type' => 'add',
                    'currency_id' => $param['currency_id'],
                    'amount' => $param['amount'],
                    'item_id' => $id,
                ]);
                Db::commit();
                $mutex->releaseLock();
            }
            return $this->apiSuccess();
        } catch (\Exception $e) {
            Db::rollback();
            $mutex->releaseLock();
            return $this->apiError($e->getMessage());
        }
    }
}