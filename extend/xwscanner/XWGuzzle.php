<?php

namespace xwscanner;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

class XWGuzzle
{
    private string $apiUrl = '';
    private int $timeout = 3;
    private Client $client;

    public function __construct($config)
    {
        if (isset($config['api_url'])) {
            $this->apiUrl = $config['api_url'];
        }
        if (isset($config['timeout'])) {
            $this->timeout = $config['timeout'];
        }

        $this->client = new Client([
            'base_uri' => $this->apiUrl,
            'timeout' => $this->timeout,
        ]);
    }


    public function reqGet($url, $param)
    {
        try {
            $resp = $this->client->request('GET', $url, [
                'query' => $param
            ]);

            if ($resp->getStatusCode() == 200) {
                $body = @json_decode($resp->getBody(), true);
                if (!empty($body['code']) && !empty($body['message'])) {
                    throw new RespException(1, $body['message']);
                } else {
                    return $body;
                }
            }
            return [];
        } catch (ClientException $e) {
            $message = $e->getResponse()->getBody()->getContents();
            throw new  RespException(1, $message);
        }

    }

    public function reqPost($url, $param)
    {
        try {
            $resp = $this->client->request('POST', $url, [
                'json' => $param
            ]);

            if ($resp->getStatusCode() == 200) {
                $body = @json_decode($resp->getBody(), true);
                if (!empty($body['code']) && !empty($body['message'])) {
                    throw new RespException(1, $body['message']);
                } else {
                    return $body;
                }
            }
            return [];
        } catch (ClientException $e) {
            $message = $e->getResponse()->getBody()->getContents();
            throw new  RespException(1, $message);
        }

    }


}