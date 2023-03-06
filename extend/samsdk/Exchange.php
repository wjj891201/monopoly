<?php

namespace samsdk;

use Carbon\Carbon;

class Exchange
{

    protected array $thirdStatus = ["NEW", "PART_FINISH", "FINISH", "CANCEL", "REJECT", "CANCELING", "FAIL"];

    private XWGuzzle $xwGuzzle;
    private string $secret = '';

    public function __construct($config)
    {
        if (isset($config['secret'])) {
            $this->secret = $config['secret'];
        }
        $this->xwGuzzle = new XWGuzzle($config);
    }

    public function getStatus($status)
    {
        return $this->thirdStatus[$status];
    }

    public function getStatusIndex($status)
    {
        for ($i = 0; $i < count($this->thirdStatus); $i++) {
            if ($this->thirdStatus[$i] == $status) {
                return $i;
            }
        }
    }


    public function adapterStatus($status)
    {
        if ($status == 'OPEN') {
            return $this->thirdStatus[0];
        } else if ($status == 'CLOSE') {
            return $this->thirdStatus[2];
        } else if ($status == 'CANCEL') {
            return $this->thirdStatus[3];
        }
        return $this->thirdStatus[6];
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


    public function getUser()
    {
        $data = [
            'timestamp' => Carbon::now()->getPreciseTimestamp(3)
        ];
        $data['signature'] = $this->createSign($data);
        ksort($data);
        return $this->xwGuzzle->reqGet('/user', $data);
    }


    public function getOrder($param)
    {
        $data = [
            'orderId' => $param['third_order_id'],
            'timestamp' => Carbon::now()->getPreciseTimestamp(3)
        ];
        $data['signature'] = $this->createSign($data);
        ksort($data);
        $resp =  $this->xwGuzzle->reqGet('/order', $data);
        return $resp[0];
    }

    public function closeOrder($param)
    {
        $data = [
            'orderId' => $param['third_order_id'],
            'timestamp' => Carbon::now()->getPreciseTimestamp(3)
        ];
        $data['signature'] = $this->createSign($data);
        ksort($data);
        return $this->xwGuzzle->reqPatch('/order/close', $data);
    }

    public function cancelOrder($param)
    {
        $data = [
            'orderId' => $param['third_order_id'],
            'timestamp' => Carbon::now()->getPreciseTimestamp(3)
        ];
        $data['signature'] = $this->createSign($data);
        ksort($data);
        return $this->xwGuzzle->reqPatch('/order/close', $data);
    }


    public function createOrder($param)
    {
        $data = [
            'symbol' => $param['pair'],
            'positionSide' => $param['side'],
            'quantity' => $param['amount'],
            'clientId' => $param['username'],
            'feeRate' => 0.01,
            'margin' => $param['margin'],
            'timestamp' => Carbon::now()->getPreciseTimestamp(3)
        ];
        $data['signature'] = $this->createSign($data);
        ksort($data);
        return $this->xwGuzzle->reqPost('/order', $data);
    }


    public function createSign($param): string
    {
        ksort($param);
        $queryString = http_build_query($param);
        $hash = hash_hmac('sha256', $queryString, $this->secret);
        return $hash;
    }


}