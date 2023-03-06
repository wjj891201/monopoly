<?php

namespace app\service;

use app\exception\RespException;
use app\model\ChainModel;
use app\model\CurrencyChainModel;
use app\model\CurrencyModel;

class CCService
{
    public CurrencyChainModel $currencyChainModel;
    private CurrencyModel $currencyModel;
    private ChainModel $chainModel;

    private bool $all;
    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new CCService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->currencyChainModel = new CurrencyChainModel();
        $this->currencyModel = new CurrencyModel();
        $this->chainModel = new ChainModel();
    }

    public function getChainById($id)
    {
        $item = $this->chainModel->find($id);
        if (empty($item)) return [];
        return $this->handleData($item);
    }

    public function getChainList($where = [])
    {
        if (!$this->all) $where[] = ['status', '=', 1];

        $list = $this->chainModel->getChainList($where);
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


    public function getCurrencyList($where = [])
    {
        if (!$this->all) $where[] = ['status', '=', 1];
        $list = $this->currencyModel->getCurrencyList($where);
        foreach ($list as $key => $value) {
            $list[$key] = $this->handleData($value);
        }
        return $list;
    }


    public function getCurrencyChainByID($id)
    {
        $item = $this->currencyChainModel->getCurrencyChain([['cc.id', '=', $id]]);
        if (empty($item)) return [];

        return $this->handleData($item);
    }

    public function getCurrencyChainByChainID($id)
    {
        $item = $this->currencyChainModel->getCurrencyChain([
            ['cc.chain_id', '=', $id],
            ['cc.contract_address', '=', ''],
        ]);
        if (empty($item)) return [];

        return $this->handleData($item);
    }

    public function getCurrencyChainList($where = [])
    {
        if (!$this->all) $where[] = ['cc.status', '=', 1];
        $list = $this->currencyChainModel->getCurrencyChainList($where);
        foreach ($list as $key => $value) {
            $list[$key] = $this->handleData($value);
        }
        return $list;
    }

    public function handleData($item)
    {
        if (!$this->all) {
            //如果下架的數據返回空
            if (isset($item['status']) && $item['status'] == 0) {
                return [];
            }
            unset($item['created_at'], $item['updated_at']);
        }

        return $item;
    }
}
