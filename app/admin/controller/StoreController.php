<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\StoreValidate;
use app\model\MemberModel;
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

           $where = search_where($param,[
                ['s.title', 'like', 'keywords'],
                ['s.cate_id'],
                ['s.type']
            ]);

            $list = $this->storeService->getStoreList($where, $param);
            return $this->apiTable($list);
        } else {
            View::assign("type_list", $this->storeService->getTypeList());
            View::assign('cate_list', $this->storeService->getCateList());
            return view();
        }
    }

    public function initForm($item)
    {
        $item = parent::initForm($item);
        $item['manager_username'] = '';
        if ($item['manager_id'] > 0) {
            $manager = (new MemberModel())->find($item['manager_id']);
            if (!empty($manager)) {
                $item['manager_username'] = $manager['username'];
            }
        }
        View::assign("type_list", $this->storeService->getTypeList());
        View::assign('cate_list', $this->storeService->getCateList());
        return $item;
    }

    public function save($param)
    {
        $member = (new MemberModel())->getByUsername($param["manager_username"]);
        if (empty($member)) {
            return $this->error('店主賬號不存在');
        }
        $param['manager_id'] = $member['id'];

        return parent::save($param);
    }
}
