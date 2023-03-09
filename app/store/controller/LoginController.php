<?php


declare (strict_types=1);

namespace app\store\controller;

use app\store\BaseController;
use app\store\validate\LoginValidate;
use Carbon\Carbon;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\Session;

class LoginController extends BaseController
{
    //登录
    public function index()
    {
        return View();
    }

    //提交登录
    public function login()
    {
        $param = get_param();
        try {
            validate(LoginValidate::class)->check($param);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $store = Db::name('member')->where(['username' => $param['username']])->find();
        if (empty($store)) {
            return $this->error('用戶名稱或者密碼不正確');
        }
        $param['password'] = create_password($param['password']);
        if ($store['password'] !== $param['password']) {
            return $this->error('用戶名稱或者密碼不正確');
        }
        if ($store['status'] == 0) {
            return $this->error('用戶帳號已經被禁用，請聯繫管理員');
        }
        $data = [
            'last_login_at' => Carbon::now()->toDateTimeString(),
            'last_login_ip' => request()->ip(),
            'login_num' => $store['login_num'] + 1,
        ];
        Db::name('member')->where(['id' => $store['id']])->update($data);
        $sessionStore = get_config('app.session_store');
        Session::set($sessionStore, $store);
        $token = make_token();
        set_cache($token, $store, 7200);
        $store['token'] = $token;
        return $this->success('登录成功', ['uid' => $store['id']]);
    }

    //退出登录
    public function login_out()
    {
        $sessionStore = get_config('app.session_store');
        Session::delete($sessionStore);
        return $this->success('退出成功');
    }
}
