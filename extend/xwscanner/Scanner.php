<?php

namespace xwscanner;

class Scanner
{
    private XWGuzzle $xwGuzzle;
    private string $key = '';
    private string $secret = '';

    public function __construct($config)
    {
        if (isset($config['key'])) {
            $this->key = $config['key'];
        }

        if (isset($config['secret'])) {
            $this->secret = $config['secret'];
        }
        $this->xwGuzzle = new XWGuzzle($config);
    }

    public function importAddress($param)
    {
        $data = [
            'app_id' => $this->key,
            'symbol' => trim($param['symbol']),
            'address' => trim($param['address']),
        ];
        return $this->xwGuzzle->reqPost('/api/address/import', $data);
    }

}