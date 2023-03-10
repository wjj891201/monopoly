<?php

namespace app\api\controller;

use app\exception\RespException;
use app\model\MemberPairModel;
use app\model\VerifyCodeModel;
use app\service\CCService;
use app\service\MemberService;
use app\model\MemberAddressModel;
use app\api\validate\AddressValidate;
use app\api\controller\CommonController;
use app\api\validate\VerifyCodeValidate;
use think\facade\Request;
use xwaddress\AddressFactory;


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
            $ccItem = CCService::getInstance(false)->getCurrencyChainByChainID($param['chain_id']);
            if (empty($ccItem)) {
                return $this->apiError('公鏈不存在');
            }
            $address = AddressFactory::create($ccItem['base_chain'], $ccItem['base_chain_protocol'], $param['address']);
            if (!$address->isValid()) {
                throw new RespException(1, '地址格式不正確');
            }
            $param['client_id'] = Request::header('X-Client-ID') ?? '';
            $id = (new MemberAddressModel())->addAddress($param);
            add_user_log('add', '提現地址', $id, $param);
            return $this->apiSuccess();
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
}
