<?php

namespace app\service;


use app\model\SellCardModel;
use app\model\SellCardOrderModel;
use app\model\SellCardUseModel;
use app\model\BuyCardModel;


class PassCheckService
{
    public SellCardModel $sellCardModel;
    public SellCardOrderModel $sellCardOrderModel;
    public SellCardUseModel $sellCardUseModel;
    public BuyCardModel $buyCardModel;


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
}
