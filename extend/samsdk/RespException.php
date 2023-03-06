<?php

namespace samsdk;

class RespException extends \RuntimeException
{

    protected mixed $data;

    public function __construct($code = 0, $message = "", $data = [])
    {
        $this->code = $code;
        $this->message = $message;
        $this->data = $data;
    }

    public function getData()
    {
        return $this->data;
    }

}