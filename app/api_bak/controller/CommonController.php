<?php

namespace app\api\controller;

use app\api\BaseController;
use app\api\middleware\Auth;
use app\model\MemberModel;

class CommonController extends BaseController
{
    protected $middleware = [Auth::class];

    protected MemberModel $memberModel;

    public function initialize()
    {
        parent::initialize();
        $this->memberModel = new MemberModel();
    }
}