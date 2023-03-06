<?php

namespace app\api\controller;

use app\model\AccountLogModel;
use app\service\AccountService;


class AccountController extends CommonController
{
    private AccountService $accountService;

    public function initialize()
    {
        parent::initialize();
        $this->accountService = new AccountService();
    }

    public function info()
    {
        try {
            $item = $this->accountService->getAccountByMemberID(JWT_UID, 2, 'funding');
            //临时初始化资产帐户
            if (empty($item)) {
                $this->accountService->createEmptyAccount(JWT_UID, 2, 'funding');
            }
            $item['available'] = round($item['available'], 2);
            return $this->apiData($item);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function log()
    {
        $param = get_param();
        try {
            $where = [
                ['l.member_id', '=', JWT_UID]
            ];
            $list = (new AccountLogModel())->getLogList($where, $param);
            return $this->apiData($list);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}
