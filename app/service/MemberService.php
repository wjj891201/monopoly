<?php

namespace app\service;

use app\model\MemberModel;
use app\model\VerifyCodeModel;
use Carbon\Carbon;
use think\Service;

class MemberService extends Service
{
    private MemberModel $memberModel;
    private bool $all;

    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new MemberService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->memberModel = new MemberModel();
    }


    public function getMemberById($id)
    {
        $member = $this->memberModel->find($id);

        if (empty($member)) return [];

        if (!$this->all) {
            unset($member['password'], $member['safe_password']);
        }
        return $member;
    }


    public function createInviteCode()
    {
        $code = mt_rand(100000, 999999);

        $member = $this->memberModel->where('invite_code', $code)->find();
        if ($member) {
            return self::createInviteCode();
        }
        return $code;
    }


    public function addMember($data)
    {
        $parent = $this->memberModel->getByInviteCode($data['invite_code']);
        if ($parent) {
            $param['pid'] = $parent['id'];
        }
        $param['password'] = create_password($data['password']);
        $param['invite_code'] = $this->createInviteCode();
        $param['register_at'] = Carbon::now()->toDateTimeString();
        $param['register_ip'] = request()->ip();
        $id = $this->memberModel->addMember($param);
        return $id;
    }

    public function checkCode($name, $code)
    {
        $code = (new VerifyCodeModel())->where(['name' => $name, 'code' => $code])->find();
        if ($code) {
            return true;
        }
        return false;
    }
}
