<?php

namespace app\api\controller;


use app\api\validate\MemberValidate;
use app\exception\RespException;
use app\service\MemberService;

class AuthController extends CommonController
{
    private MemberService $memberService;


    public function initialize()
    {
        parent::initialize();
        $this->memberService = new MemberService(false);
    }

    public function email()
    {
        try {

            $param = get_param();
            validate(MemberValidate::class)->scene("email")->check($param);
            $member = $this->memberModel->find(JWT_UID);
            $param['id'] = $member['id'];

            //验证email是否存在
            $checkEmail = $this->memberModel->getByEmail($param["email"]);
            if ($checkEmail) {
                throw new RespException(1, 'Email已存在');
            }

            //驗證老郵箱驗證碼
            if (!$this->memberService->checkCode($member['email'], $param['verify_code'])) {
                throw new RespException(1, '原始验证码不正确');
            }

            //驗證老郵箱驗證碼
            if (!$this->memberService->checkCode($param['email'], $param['email_code'])) {
                throw new RespException(1, '新验证码不正确');
            }

            $this->memberModel->editMember($param);
            add_user_log('edit', '修改email', $member['id'], ["old_email" => $member["email"], "new_email" => $param["email"]]);
            return $this->apiSuccess('修改成功');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function loginPassword()
    {
        $param = get_param();

        try {
            $member = $this->memberModel->find(JWT_UID);
            $param['email'] = $member['email'];

            validate(MemberValidate::class)->scene("password")->check($param);

            $password = create_password($param['password']);
            $this->memberModel->editMember(['id'=>$member['id'],'password'=>$password]);

            add_user_log('edit', '修改密碼', $member['id']);
            return $this->apiSuccess('修改成功，請去登入');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function safePassword()
    {
        $param = get_param();

        try {
            $member = $this->memberModel->find(JWT_UID);
            $param['email'] = $member['email'];
            validate(MemberValidate::class)->scene("password")->check($param);
            $safe_password = create_password($param['password']);
            $this->memberModel->editMember(['id'=>$member['id'],'safe_password'=>$safe_password]);
            add_user_log('edit', '修改安全密碼', $member['id']);
            return $this->apiSuccess('修改成功');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}