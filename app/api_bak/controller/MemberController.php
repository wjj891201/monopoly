<?php

namespace app\api\controller;

use app\model\MemberPairModel;
use app\model\VerifyCodeModel;
use app\service\MemberService;
use app\model\MemberAddressModel;
use app\api\validate\AddressValidate;
use app\api\controller\CommonController;
use app\api\validate\VerifyCodeValidate;


class MemberController extends CommonController
{
    private MemberService $memberService;

    public function initialize()
    {
        parent::initialize();
        $this->memberService = new MemberService(false);
    }


    public function info()
    {
        $member = $this->memberService->getMemberById(JWT_UID);
        if (empty($member)) {
            return $this->apiError('用户不存在');
        }
        return $this->apiData($member);
    }

    public function addressList()
    {
        $param = get_param();
        $list = (new MemberAddressModel())->getAddressList([['a.member_id', '=', JWT_UID]], $param);
        return $this->apiData($list);
    }

    public function addressAdd()
    {
        $param = get_param();
        try {
            validate(AddressValidate::class)->check($param);
            $param['member_id'] = JWT_UID;
            $id = (new MemberAddressModel())->addAddress($param);
            add_user_log('add', '地址', $id, $param);
            return $this->apiSuccess('发送成功');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function sendVerifyCode()
    {

        $param = get_param();
        try {
            $param["email"] = $param["username"] ?? '';
            validate(VerifyCodeValidate::class)->scene('member_send')->check($param);
            //todo 執行發送
            //保存驗證碼
            $code = mt_rand(1000, 9999);
            (new VerifyCodeModel())->addCode(['name' => $param['username'], 'code' => $code]);
            return $this->apiSuccess('发送成功');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    public function pair()
    {
        $param = get_param();
        try {

            $memberPairModel = new MemberPairModel();
            $memberPair = $memberPairModel->getPairByMemberID(JWT_UID, $param['pair_id'], $param['cate']);
            if ($memberPair) {
                $memberPairModel->where('id', $memberPair['id'])->delete();
            } else {
                $data = [
                    'cate' => $param['cate'],
                    'pair_id' => $param['pair_id'],
                    'member_id' => JWT_UID
                ];
                $memberPairModel->addPair($data);
            }
            return $this->apiSuccess('操作成功');
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}
