<?php

namespace app\api\controller;

use think\facade\Db;
use think\facade\Log;
use think\facade\Config;
use app\model\StoreModel;
use app\facade\MutexFacade;
use app\model\StoreCateModel;
use app\service\StoreService;
use app\exception\RespException;
use app\validate\CommonValidate;
use app\api\validate\StoreValidate;
use app\api\controller\CommonController;

class StoreController extends CommonController
{
    protected StoreModel $storeModel;
    protected StoreService $storeService;

    public function initialize()
    {
        parent::initialize();
        $this->storeModel = new StoreModel();
        $this->storeService = new StoreService(false);
    }


    public function cates()
    {
        $pid = get_param('pid');
        $list = (new StoreCateModel())->getCateList([['pid', '=', $pid], ['status', '=', 1]]);
        return $this->apiData($list);
    }

    public function list()
    {
        $param = get_param();
        $where = [['s.status', '=', 1]];
        if (!empty($param['cate_id'])) {
            $where[] = ['s.cate_id', '=', $param['cate_id']];
        }
        $list = $this->storeService->getStoreList($where, $param);
        return $this->apiData($list);
    }

    public function info()
    {
        $param = get_param();
        if (empty($param['id'])) {
            return $this->apiError('参数错误');
        }
        $item = $this->storeService->getStoreById($param['id']);
        if (empty($item) || $item['status'] == 0) {
            $this->apiError('數據不存在');
        }
        return $this->apiData($item);
    }


    public function order_list()
    {
        $param = get_param();
        $where = [['o.member_id', '=', JWT_UID]];
        if (isset($param['status'])) {
            $where[] = ['o.status', '=', $param['status']];
        }
        $list = $this->storeService->getOrderList($where, $param);

        return $this->apiData($list);
    }

    public function order_info()
    {
        $param = get_param();
        if (empty($param['id'])) {
            return $this->apiError('参数错误');
        }
        $item = $this->storeService->getOrderById($param['id']);
        if (empty($item)) {
            $this->apiError('數據不存在');
        }
        return $this->apiData($item);
    }

    public function pay()
    {
        $mutex = MutexFacade::create("store_order");
        Db::startTrans();
        try {
            $param = get_param();
            $param['member_id'] = JWT_UID;
            validate(StoreValidate::class)->check($param);

            $member = $this->memberModel->find(JWT_UID);
            if ($member['status'] == 0) {
                throw new RespException(1, '帳號禁用');
            }

            if ($mutex->acquireLock(Config::get('mutex.timeout'))) {
                $id = $this->storeService->orderPay($member, $param);
                add_user_log("add", '商戶下單', $id, $param);
                Db::commit();
                $mutex->releaseLock();
            }
            return $this->apiSuccess();
        } catch (\Exception $e) {
            Db::rollback();
            $mutex->releaseLock();
            Log::error($e->getMessage());
            return $this->apiError($e->getMessage());
        }
    }
}
