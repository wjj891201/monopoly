<?php

namespace app\service;

use app\model\AccountWithdrawModel;

class WithdrawService
{
    public AccountWithdrawModel $withdrawModel;

    private static $instance = null;

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new WithdrawService();
        }
        return self::$instance;
    }

    public function __construct()
    {
        $this->withdrawModel = new AccountWithdrawModel();
    }

    public function getWithdrawById($id)
    {
        $item = $this->withdrawModel->find($id);
        if (empty($item)) return [];
        $item['status_name'] = $this->getStatusName($item['status']);
        return $item;
    }


    public function getWithdrawList($where = [], $param = [])
    {
        $result = $this->withdrawModel->getWithdrawList($where, $param);
        foreach ($result as $key => $value) {
            $value['status_name'] = $this->getStatusName($value->status);
            $result[$key] = $value;
        }
        return $result;
    }

    public function getStatusName($status)
    {
        switch ($status) {
            case 'created':
                $status_name = '待審核';
                break;
            case 'checked':
                $status_name = '已審核';
                break;
            case 'refused':
                $status_name = '拒絕';
                break;
            case 'finished':
                $status_name = '提現成功';
                break;
            default:
                $status_name = '未知';
        }
        return $status_name;
    }
}
