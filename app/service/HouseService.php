<?php

namespace app\service;

use app\model\HouseCateModel;
use app\model\HouseModel;
use app\model\HouseOrderModel;
use think\facade\Config;
use think\facade\Db;

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
        return $result;
    }

    //获取历史房产
    public function getHistoryHouse($id)
    {
        $result = Db::name('house')->alias('h')
            ->field(['h.id', 'h.pid', 'h.title', 'h.price', 'h.created_at', 'c.title cate_title', 'm.username'])
            ->join('house_cate c', 'c.id=h.cate_id')
            ->join('member m', 'm.id=h.owner_id')
            ->where(['h.id' => $id])->select()->toArray();
        if (empty($result)) {
            return [];
        } else {
            foreach ($result as $key => $val) {
                $temp = $this->getHistoryHouse($val['pid']);
                $result = array_merge($result, $temp);
            }
        }
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
