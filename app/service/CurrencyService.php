<?php

namespace app\service;

use app\model\CurrencyModel;

class CurrencyService
{
    public CurrencyModel $currencyModel;
    private bool $all;

    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new CurrencyService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->currencyModel = new CurrencyModel();
    }


    public function getCurrencyList($where = [])
    {
        $list = $this->currencyModel->getCurrencyList($where);
        foreach ($list as $key => $value) {
            $list[$key] = $this->handleData($value);
        }
        return $list;
    }

    public function getCurrencyById($id)
    {
        $item = $this->currencyModel->find($id);

        if (empty($item)) return [];

        return $this->handleData($item);
    }


    public function handleData($item)
    {
        if (!$this->all) {
            unset($item['created_at'], $item['updated_at']);
        }
        return $item;
    }
}
