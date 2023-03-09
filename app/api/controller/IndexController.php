<?php


namespace app\api\controller;

use app\api\BaseController;
use app\api\validate\VerifyCodeValidate;
use app\facade\CaptchaFacade;
use app\facade\MutexFacade;
use app\model\VerifyCodeModel;
use Ramsey\Uuid\Uuid;
use think\facade\Config;
use think\facade\Request;

class IndexController extends BaseController
{

    public function index()
    {
       return 'api_index';
    }

    public function uuid()
    {
        $uuid = Uuid::uuid4()->toString();
        return $this->apiData(['uuid' => $uuid]);
    }

    public function captcha()
    {
        $client_id = get_param('client_id');
        if (!$client_id) {
            return $this->apiError('參數不正確');
        }
        return CaptchaFacade::create(null, false, $client_id);
    }

    public function sendVerifyCode()
    {
        $param = get_param();
        try {
            $param['client_id'] =  Request::header('X-Client-ID');

            validate(VerifyCodeValidate::class)->scene('captcha_send')->check($param);
            //todo 執行發送
            $code = mt_rand(1000, 9999);
            (new VerifyCodeModel())->addCode(['name' => $param['username'], 'code' => $code]);
            return $this->apiSuccess('发送成功');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}
