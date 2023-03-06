<?php

namespace xwwallet;


class Common
{

    private XWGuzzle $xwGuzzle;

    public function __construct($config)
    {
        $this->xwGuzzle = new XWGuzzle($config);
    }

    /**
     * 發送email
     * @param $param
     * @return mixed
     */
    public function sendEmail($param): mixed
    {
        $data = [
            'to' => $param['email'],
            'subject' => $param['subject'],
            'body' => $param['content'],
        ];
        return $this->xwGuzzle->reqPost('/api/send-email', $data);
    }
}