<?php

namespace xwwallet;


class Exchange
{
    private XWGuzzle $xwGuzzle;
    private string $secret = '';

    protected array $thirdStatus = ["NEW", "PART_FINISH", "FINISH", "CANCEL", "REJECT", "CANCELING", "FAIL"];

    public function __construct($config)
    {
        if (isset($config['secret'])) {
            $this->secret = $config['secret'];
        }

        $this->xwGuzzle = new XWGuzzle($config);
    }

    public function getStatus($status){
        return $this->thirdStatus[$status];
    }

    public function pairPrice($param)
    {
        $data = [
            'base' => $param['base'],
            'quote' => $param['quote'],
        ];

        $data['sign'] = $this->createSign($data);
        return $this->xwGuzzle->reqGet('/api/pair/info', $data);
    }

    public function getOrder($param)
    {
        $data = [
            'base' => $param['base_code'],
            'quote' => $param['quote_code'],
            'order_sn' => $param['third_order_id'],
        ];

        $data['sign'] = $this->createSign($data);
        return $this->xwGuzzle->reqGet('/api/order/info', $data);
    }

    public function cancelOrder($param)
    {
        $data = [
            'base' => $param['base_code'],
            'quote' => $param['quote_code'],
            'order_sn' => $param['third_order_id'],
        ];

        $data['sign'] = $this->createSign($data);
        return $this->xwGuzzle->reqGet('/api/order/cancel', $data);
    }


    public function createOrder($param)
    {
        $data = [
            'base' => $param['base'],
            'quote' => $param['quote'],
            'price' => floatval($param['price']),
            'amount' => floatval($param['amount']),
            'side' => $param['side'],
            'type' => $param['type'],
        ];

        $data['sign'] = $this->createSign($data);
        return $this->xwGuzzle->reqPost('/api/order/create', $data);
    }


    public function createSign($param): string
    {
        ksort($param);
        $queryString = http_build_query($param);
        $hash = hash_hmac('sha256', $queryString, $this->secret);
        return $hash;
    }


}