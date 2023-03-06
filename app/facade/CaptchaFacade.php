<?php

namespace app\facade;

use app\service\CaptchaService;
use think\Facade;

class CaptchaFacade extends Facade
{
    protected static function getFacadeClass()
    {
        return CaptchaService::class;
    }
}