<?php

namespace samsdk;

use Carbon\Carbon;
use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

class XWGuzzle
{
    private string $apiUrl = '';
    private int $timeout = 3;
    private Client $client;
    private string $key = '';

    public function __construct($config)
    {
        if (isset($config['key'])) {
            $this->key = $config['key'];
        }

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
                'query' => $param,
                'headers' => [
                    'apikey' => $this->key,
                ]
            ]);

            if ($resp->getStatusCode() == 200) {
                $resp =  @json_decode($resp->getBody(), true);
                return $resp['data'];
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
                'json' => $param,
                'headers' => [
                    'apikey' => $this->key,
                ]
            ]);

            if ($resp->getStatusCode() == 200) {
                $resp =  @json_decode($resp->getBody(), true);
                return $resp['data'];
            }
            return [];
        } catch (ClientException $e) {
            $message = $e->getResponse()->getBody()->getContents();
            throw new  RespException(1, $message);
        }

    }

    public function reqPatch($url, $param)
    {
        try {
            $resp = $this->client->request('PATCH', $url, [
                'json' => $param,
                'headers' => [
                    'apikey' => $this->key,
                ]
            ]);

            if ($resp->getStatusCode() == 200) {
                $resp =  @json_decode($resp->getBody(), true);
                return $resp['data'];
            }
            return [];
        } catch (ClientException $e) {
            $message = $e->getResponse()->getBody()->getContents();
            throw new  RespException(1, $message);
        }

    }


}