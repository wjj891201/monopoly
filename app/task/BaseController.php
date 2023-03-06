<?php

namespace app\task;


use Carbon\Carbon;
use think\App;
use think\Response;

/**
 * 控制器基础类
 */
abstract class BaseController
{


    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    /**
     * 应用实例
     * @var \think\App
     */
    protected $app;

    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;

    /**
     * 控制器中间件
     * @var array
     */
    protected $middleware = [];


    protected $param;

    protected $mutexConfig;

    /**
     * 构造方法
     * @access public
     * @param App $app 应用对象
     */
    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $this->app->request;

        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    protected function initialize()
    {
        $this->param = $this->request->param();
    }


    protected function apiSuccess($msg = 'success', $data = [])
    {
        return $this->apiReturn($data, 0, $msg);
    }

    protected function apiData($data = [])
    {
        return $this->apiReturn($data, 0, "success");
    }


    protected function apiError($msg = 'error', $data = [], $code = 1)
    {
        return $this->apiReturn($data, $code, $msg);
    }


    protected function apiReturn($data, int $code = 0, $msg = '', $httpCode = 200, array $header = [])
    {
        $result = [
            'code' => $code,
            'msg' => $msg,
            'time' => Carbon::now()->toDateTimeString(),
            'data' => $data,
        ];

        return json($result, $httpCode, $header);
    }

}
