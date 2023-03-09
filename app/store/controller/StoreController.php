<?php

namespace app\store\controller;

use app\facade\QrCodeFacade;
use app\store\BaseController;
use app\store\validate\StoreValidate;
use app\model\StoreModel;
use app\service\StoreService;
use think\facade\View;

class StoreController extends BaseController
{
    private StoreService $storeService;

    public function initialize()
    {
        parent::initialize();
        $this->storeService = new StoreService();
        $this->setTable((new StoreModel())->getTable());
        $this->setValidate(validate(StoreValidate::class));
    }

    public function list()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = [['manager_id', '=', get_login_store('id')]];
            if (!empty($param['keywords'])) {
                $where[] = ['s.title', 'like', '%' . $param['keywords'] . '%'];
            }
            if (!empty($param['cate_id'])) {
                $where[] = ['s.cate_id', '=', $param['cate_id']];
            }
            if (!empty($param['type'])) {
                $where[] = ['s.type', '=', $param['type']];
            }
            $list = $this->storeService->getStoreList($where, $param);


            foreach ($list as $key=>$value){
                $url = 'https://wallet.beebitpay.com/#/pages/store/pay?store_id='.$value['id'];
                $value['qrcode'] = QrCodeFacade::createCode($url,$value['id']);
                $list[$key] = $value;
            }

            return $this->apiTable($list);
        } else {
            return view();
        }
    }

    public function initForm($item)
    {
        $item = parent::initForm($item);
        View::assign('cate_list', $this->storeService->getCateList());
        return $item;
    }
}