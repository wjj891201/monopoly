<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\HouseValidate;
use app\model\HouseModel;
use app\service\HouseService;
use think\facade\View;

class HouseController extends BaseController
{

    private HouseService $houseService;

    public function initialize()
    {
        parent::initialize();
        $this->houseService = new HouseService();
        $this->setTable((new HouseModel())->getTable());
        $this->setValidate(validate(HouseValidate::class));
    }

    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [
                ['a.title', 'like', 'keywords'],
                ['a.cate_id']
            ]);
            $list = $this->houseService->getHouseList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

//    public function initForm($item)
//    {
//        View::assign("type_list", $this->houseService->getTypeList());
//        return $item;
//    }
}
