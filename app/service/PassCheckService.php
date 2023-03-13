<?php

namespace app\service;


use app\model\SellCardModel;


class PassCheckService
{
    public SellCardModel $sellCardModel;


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
    }

    public function getSellCardList($where = [], $param = [])
    {
        $result = $this->sellCardModel->getSellCardList($where, $param);
        return $result;
    }
}
