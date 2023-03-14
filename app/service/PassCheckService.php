<?php

namespace app\service;


use app\model\SellCardModel;
use app\model\SellCardOrderModel;
use app\model\SellCardUseModel;
use app\model\BuyCardModel;
use app\model\BuyCardOrderModel;
use app\model\BuyCardUseModel;


class PassCheckService
{
    public SellCardModel $sellCardModel;
    public SellCardOrderModel $sellCardOrderModel;
    public SellCardUseModel $sellCardUseModel;
    public BuyCardModel $buyCardModel;
    public BuyCardOrderModel $buyCardOrderModel;
    public BuyCardUseModel $buyCardUseModel;


    private static $instance = null;

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new PassCheckService();
        }
        return self::$instance;
    }


    public function __construct()
    {
        $this->sellCardModel = new SellCardModel();
        $this->sellCardOrderModel = new SellCardOrderModel();
        $this->sellCardUseModel = new SellCardUseModel();
        $this->buyCardModel = new BuyCardModel();
        $this->buyCardOrderModel = new BuyCardOrderModel();
        $this->buyCardUseModel = new BuyCardUseModel();
    }

    /**
     * 掛賣寶列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getSellCardList($where = [], $param = [])
    {
        $result = $this->sellCardModel->getSellCardList($where, $param);
        return $result;
    }

    /**
     * 掛賣寶訂單列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getSellCardOrderList($where = [], $param = [])
    {
        $result = $this->sellCardOrderModel->getSellCardOrderList($where, $param);
        return $result;
    }

    /**
     * 掛賣寶使用列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getSellCardUseList($where = [], $param = [])
    {
        $result = $this->sellCardUseModel->getSellCardUseList($where, $param);
        return $result;
    }

    /**
     * 搶房寶列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getBuyCardList($where = [], $param = [])
    {
        $result = $this->buyCardModel->getBuyCardList($where, $param);
        return $result;
    }

    /**
     * 搶房寶訂單列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getBuyCardOrderList($where = [], $param = [])
    {
        $result = $this->buyCardOrderModel->getBuyCardOrderList($where, $param);
        return $result;
    }

    /**
     * 搶房寶使用列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getBuyCardUseList($where = [], $param = [])
    {
        $result = $this->buyCardUseModel->getBuyCardUseList($where, $param);
        return $result;
    }
}
