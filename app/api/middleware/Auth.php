<?php


namespace app\api\middleware;


use Firebase\JWT\JWT;
use Firebase\JWT\Key;
use think\facade\Request;

class Auth
{
    public function handle($request, \Closure $next)
    {
        $token = Request::header('X-Token');
        if ($token) {
            if (count(explode('.', $token)) != 3) {
                return json(['code' => 404, 'msg' => '非法请求']);
            }

            try {
                $secret = get_config('member.api.secret');
                JWT::$leeway = 60;//当前时间减去60，把时间留点余地
                $decoded = JWT::decode($token, new Key($secret, 'HS256')); //HS256方式，这里要和签发的时候对应
                $decoded_array = json_decode(json_encode($decoded), TRUE);
                $jwt_data = $decoded_array['data'];
                define('JWT_UID', $jwt_data['uid']);
                return $next($request);
            } catch (\Exception $e) {
                return json(['code' => 401, 'msg' => 'token失效'], 401);
            }
        } else {
            return json(['code' => 404, 'msg' => 'token不能为空'], 401);
        }
    }
}