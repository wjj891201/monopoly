<?php

/**
 * api调用配置
 */

return [
    'common' => [
        'timeout' => 3,
        'api_url' => 'http://52.196.83.115:1122'
    ],
    'wallet' => [
        'timeout' => 3,
        'api_url' => 'http://127.0.0.1:9999',
        'key' => 'DEMO2HXWV7AG15Y619',
        'secret' => 'DEMO2WM9NS5FV859D4G67S2RG6TDCKU9WH',
    ],
    'scanner' => [
        'timeout' => 3,
        'api_url' => 'http://127.0.0.1:9999',
        'key' => 'DEMO2HXWV7AG15Y619',
    ],
    'exchange' => [
        'timeout' => 3,
        'api_url' => 'http://127.0.0.1:8899',
        'secret' => 'tr9qzntsUnGOJyNZ9h1vRsW6'
    ],
];
