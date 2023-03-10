<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\HouseOrderModel;
use app\service\HouseService;
use think\facade\View;

class HouseOrderController extends BaseController
{

    private HouseService $houseService;

    public function initialize()
    {
        parent::initialize();
        $this->houseService = new HouseService();
        $this->setTable((new HouseOrderModel())->getTable());
//        $this->setValidate(validate(HouseValidate::class));
    }

    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [
//                ['a.title', 'like', 'keywords'],
                ['o.cate_id']
            ]);
            $list = $this->houseService->getHouseOrderList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}
