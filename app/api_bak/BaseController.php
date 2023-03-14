<?php


declare (strict_types=1);

namespace app\api;

use Carbon\Carbon;
use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use think\App;
use think\exception\HttpResponseException;
use think\facade\Request;
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

    protected $param;

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

    /**
     * 分页数量
     * @var string
     */
    protected $pageSize = '';


    /**
     * 构造方法
     * @access public
     * @param App $app 应用对象
     */
    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $this->app->request;
        $this->jwt_conf = get_system_config('token');
        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    public function initialize()
    {
        $this->param = $this->request->param();


    }


    public function createToken($user_id)
    {
        $time = time(); //当前时间
        $secret = get_config('member.api.secret');
        $times = get_config('member.api.expire_times');
        $token = [
            'iat' => $time, //签发时间
            'nbf' => $time - 1, //(Not Before)：某个时间点后才能访问，比如设置time+30，表示当前时间30秒后才能使用
            'exp' => $time + $times, //过期时间,这里设置2个小时
            'data' => [
                //自定义信息，不要定义敏感信息
                'uid' => $user_id,
            ]
        ];
        return JWT::encode($token, $secret, 'HS256'); //输出Token  默认'HS256'
    }

    public function getUid()
    {
        $token = Request::header('X-Token');
        if ($token) {
            if (count(explode('.', $token)) != 3) {
                return 0;
            }
            try {
                $secret = get_config('member.api.secret');
                JWT::$leeway = 60;//当前时间减去60，把时间留点余地
                $decoded = JWT::decode($token, new Key($secret, 'HS256')); //HS256方式，这里要和签发的时候对应
                $decoded_array = json_decode(json_encode($decoded), TRUE);
                $jwt_data = $decoded_array['data'];
                return $jwt_data['uid'];
            } catch (\Exception $e) {
                return 0;
            }
        } else {
            return 0;
        }
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
