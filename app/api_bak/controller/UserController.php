<?php

namespace app\api\controller;

use app\api\BaseController;
use app\api\validate\MemberValidate;
use app\exception\RespException;
use app\model\MemberModel;
use app\service\MemberService;
use Carbon\Carbon;


class UserController extends BaseController
{

    private MemberModel $memberModel;
    private MemberService $memberService;

    public function initialize()
    {
        parent::initialize();
        $this->memberModel = new MemberModel();
        $this->memberService = new MemberService();
    }

    public function login()
    {
        $param = get_param();
        try {
            $member = $this->memberModel->getByUsername($param["username"]);
            if (empty($member)) {
                throw new RespException(1, '帐号或密码错误');
            }
            $param['member_id'] = $member['id'];
            validate(MemberValidate::class)->scene("login")->check($param);

            if ($member['status'] == 0) {
                return $this->apiError('该用户禁止登录,请于平台联系');
            }

            $data = [
                'id' => $member['id'],
                'last_login_at' => Carbon::now()->toDateTimeString(),
                'last_login_ip' => $this->request->ip(),
                'login_num' => $member['login_num'] + 1,
            ];
            $this->memberModel->editMember($data);
            $token = self::createToken($member['id']);
            add_user_log('api', '登录', $member['id']);
            return $this->apiSuccess('登录成功', ['token' => $token]);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function register()
    {
        $param = get_param();

        try {
            //1.1、输入验证
            validate(MemberValidate::class)->scene("register")->check($param);

            //1.2 数据安全验证
            $member = $this->memberModel->getByUsername($param["username"]);
            if ($member) {
                throw new RespException(1, '该账户已经存在');
            }

            $parent = $this->memberModel->getByInviteCode($param['invite_code']);
            if (empty($parent)) {
                throw new RespException(1, '推薦碼不存在');
            }
            $uid = $this->memberService->addMember($param);
            add_user_log('api', '注册', $uid);
            return $this->apiSuccess('注册成功,请登录');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function forget()
    {
        $param = get_param();
        try {
            $member = $this->memberModel->getByUsername($param['username']);
            if (empty($member)) {
                throw new RespException(1, '帐号不存在');
            }
            $param['email'] = $member['email'];
            validate(MemberValidate::class)->scene("forget")->check($param);

            if ($member['status'] == 0) {
                throw new RespException(1, '该用户禁止登录,请于平台联系');
            }

            $param['password'] = create_password($param['password']);
            $this->memberModel->editMember($member['id'], $param);
            return $this->apiSuccess('修改成功，請去登入');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}
