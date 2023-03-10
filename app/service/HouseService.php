<?php

namespace app\service;

use app\model\HouseCateModel;
use app\model\HouseModel;
use app\model\HouseOrderModel;
use think\facade\Config;

class HouseService
{
    public HouseModel $houseModel;
    public HouseCateModel $cateModel;
    public HouseOrderModel $orderModel;
    private bool $all;

    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new HouseService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->cateModel = new HouseCateModel();
        $this->houseModel = new HouseModel();
        $this->orderModel = new HouseOrderModel();
    }

    public function getHouseById($id)
    {
        $item = $this->houseModel->find($id);
        if (empty($item)) {
            return [];
        }
        $item = $this->handleData($item);
        return $item;
    }

    /**
     * 房產列表
     * @param array $where
     * @param array $param
     * @return mixed
     */
    public function getHouseList($where = [], $param = [])
    {
        $result = $this->houseModel->getHouseList($where, $param);
        foreach ($result as $key => $value) {
            $result[$key] = $this->handleData($value);
        }
        return $result;
    }

    public function getHouseOrderList($where = [], $param = [])
    {
        $result = $this->orderModel->getHouseOrderList($where, $param);
//        foreach ($result as $key => $value) {
//            $result[$key] = $this->handleData($value);
//        }
        return $result;
    }


    public function handleData($item)
    {
        if (!$this->all) {
            unset($item['admin_id'], $item['status'], $item['admin_name']);
        }
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
