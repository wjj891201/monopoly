<?php


namespace app\service;

use app\exception\RespException;
use app\model\SpotOrderModel;
use app\model\SpotPairModel;
use Carbon\Carbon;
use think\facade\Config;
use xwwallet\Exchange;

class SpotService
{
    public SpotPairModel $pairModel;
    public SpotOrderModel $orderModel;
    private bool $all;
    protected array $statusList = [
        'pending' => '正在下单',
        'new' => '已掛單',
        'part_finish' => '部分完成',
        'finish' => '已完成',
        'cancel' => '已撤單',
        'reject' => '撤單中',
        'canceling' => '未知錯誤',
        'fail' => '已過期',
    ];

    protected array $sideList = [
        'buy' => '買單',
        'sell' => '賣單',
    ];

    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new SpotService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->pairModel = new SpotPairModel();
        $this->orderModel = new SpotOrderModel();
    }

    public function getPairById($id)
    {
        $where[] = ['p.id', '=', $id];
        if (!$this->all) $where[] = ['p.is_show', '=', 1];
        $item = $this->pairModel->getPairByWhere($where);
        return $this->handlePair($item);
    }

    public function getPairByCode($code)
    {
        $where[] = ['p.code', '=', $code];
        if (!$this->all) $where[] = ['p.is_show', '=', 1];
        $item = $this->pairModel->getPairByWhere($where);
        return $this->handlePair($item);
    }

    public function getPairList($where = [])
    {
        if (!$this->all) $where[] = ['p.is_show', '=', 1];
        $list = $this->pairModel->getPairList($where);
        foreach ($list as $key => $value) {
            $list[$key] = $this->handlePair($value);
        }
        return $list;
    }

    public function getPairPrice($base, $quote = 'USDT')
    {
        if ($base == $quote) {
            return 1;
        }
        $pair = $this->getPairByCode(strtolower($base . $quote));

        if (isset($pair['last_price'])) {
            return round($pair['last_price'], $pair['price_decimal']);
        }
        return 0;
    }

    public function handlePair($item)
    {

        if (!$this->all) {
            unset($item['created_at'], $item['updated_at']);
        }
        $item['display_name'] = $item['base_code'] . $item['delimiter'] . $item['quote_code'];
        return $item;
    }
}
