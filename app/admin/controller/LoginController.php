<?php


declare (strict_types = 1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\MemberValidate;
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
            validate(MemberValidate::class)->check($param);
        } catch (ValidateException $e) {
            return $this->error($e->getError());
        }

        $admin = Db::name('admin')->where(['username' => $param['username']])->find();
        if (empty($admin)) {
            return $this->error('用户名或密码错误');
        }
        $param['password'] = create_password($param['password']);
        if ($admin['password'] !== $param['password']) {
            return $this->error('用户名或密码错误');
        }
        if ($admin['status'] == 0) {
            return $this->error('该用户禁止登录,请于系统所有者联系');
        }
        $data = [
            'last_login_at' => Carbon::now()->toDateTimeString(),
            'last_login_ip' => request()->ip(),
            'login_num' => $admin['login_num'] + 1,
        ];
        Db::name('admin')->where(['id' => $admin['id']])->update($data);
        $session_admin = get_config('app.session_admin');
        Session::set($session_admin, $admin);
        $token = make_token();
        set_cache($token, $admin, 7200);
        $admin['token'] = $token;
        add_log('login', $admin['id'], $data);
        return $this->success('登录成功', ['uid' => $admin['id']]);
    }

    //退出登录
    public function login_out()
    {
        $session_admin = get_config('app.session_admin');
        Session::delete($session_admin);
        return $this->success('退出成功');
    }
}
