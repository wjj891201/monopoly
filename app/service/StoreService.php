<?php

namespace app\service;

use app\exception\RespException;
use app\model\StoreCateModel;
use app\model\StoreModel;
use app\model\StoreOrderModel;
use Carbon\Carbon;
use think\facade\Config;

class StoreService
{
    public StoreModel $storeModel;
    public StoreCateModel $cateModel;
    public StoreOrderModel $orderModel;
    private bool $all;
    private array $typeList = ['普通', '推薦1', '推薦2', '推薦3', '推薦4', '推薦5', '推薦6', '推薦7', '推薦8', '推薦9', '推薦10'];
    protected array $statusList = [
        'new' => '未支付',
        'finish' => '已完成',
        'cancel' => '已撤單',
        'reject' => '未知錯誤',
    ];

    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new StoreService($all);
        }
        return self::$instance;
    }


    public function __construct($all = true)
    {
        $this->all = $all;
        $this->cateModel = new StoreCateModel();
        $this->storeModel = new StoreModel();
        $this->orderModel = new StoreOrderModel();
    }

    public function getTypeList()
    {
        return $this->typeList;
    }

    public function getStoreById($id)
    {
        $item = $this->storeModel->find($id);
        if (empty($item)) {
            return [];
        }
        $item = $this->storeData($item);
        return $item;
    }

    public function getStoreList($where = [], $param = [])
    {
        $result = $this->storeModel->getStoreList($where, $param);
        foreach ($result as $key => $value) {
            $result[$key] = $this->storeData($value);
        }
        return $result;
    }


    public function getCateList()
    {
        return $this->cateModel->where([['status', '=', 1]])->select();
    }

    public function getOrderById($id)
    {
        $order = $this->orderModel->getOrderByID($id);
        return $this->handleOrder($order);
    }

    public function getOrderBySN($orderSN)
    {
        $order = $this->orderModel->getOrderBySN($orderSN);
        return $this->handleOrder($order);
    }


    public function getOrderList($where = [], $param = [])
    {
        $result = $this->orderModel->getOrderList($where, $param);
        foreach ($result as $key => $value) {
            $result[$key] = $this->handleOrder($value);
        }
        return $result;
    }


    public function orderPay($member, $order)
    {
        //1、檢查訂單金額
        if (!$this->checkOrder($order)) {
            return 0;
        }

        //2、檢查用很多可用餘額
        $this->checkAccount($member, $order);

        //3、保存订单
        $data = [
            'order_sn' => $this->createOrderSN(),
            'member_id' => $order['member_id'],
            'store_id' => $order['store_id'],
            'amount' => $order['amount'],
            'status' => 'new',
        ];
        $orderID =  $this->orderModel->addOrder($data);

        //減少用戶資產
        $isSub = (new AccountService())->subFundingAvailable($order['member_id'], 2, $order['amount'], $orderID, '商戶交易');

        //更改用戶狀態
        if ($isSub === true) {
            //5、修改自己訂單狀態
            $data = [
                'id' => $orderID,
                'status' => 'finish',
                'finished_at' => Carbon::now()->toDateTimeString()
            ];
            $this->orderModel->editOrder($data);
        }
        return $orderID;
    }


    public function checkAccount($member, $order)
    {
        $param = [
            'member_id' => $member['id'],
            'asset_type' => 'funding',
            'balance_type' => 'available',
            'amount' => $order['amount'],
            'currency_id' => 2,
        ];
        return (new AccountService())->checkAccount($param);
    }


    public function checkOrder($order): bool
    {
        if ($order['amount'] <= 0) {
            throw new RespException(1, '訂單金額不正確');
        }
        return true;
    }


    public function createOrderSN()
    {
        $code = mt_rand(10000000, 99999999);
        $code = 'STORE' . $code;
        $order = $this->orderModel->where('order_sn', $code)->find();
        if ($order) {
            return $this->createOrderSN();
        }
        return $code;
    }


    public function handleOrder($order)
    {
        $status = strtolower($order['status']);
        if (isset($this->statusList[$status])) {
            $order['status_name'] = $this->statusList[$status];
        }
        return $order;
    }

    public function storeData($item)
    {
        if (!$this->all) {
            unset($item['admin_id'], $item['status']);
        }
        $item["type_name"] = $this->typeList[$item["type"]];
        if (!empty($item['image'])) {
            $item['image_url'] = get_file($item['image']);
        }

        //替換文章內容路徑
        $domain = Config::get('filesystem.url');
        $replaceStr = 'src="' . $domain . '/storage';
        $item['content'] = str_replace('src="/storage', $replaceStr, $item['content']);


        return $item;
    }
}
