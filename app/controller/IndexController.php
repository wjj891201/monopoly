<?php

namespace app\controller;

use app\api\BaseController;
use samsdk\Exchange;
use think\facade\Config;


class IndexController extends BaseController
{
    public function index()
    {
        return 'hello~!';
    }
}
