<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\service\PassCheckService;
use app\model\SellCardOrderModel;
use app\exception\RespException;


class SellCardOrderController extends BaseController
{
    private PassCheckService $passCheckService;

    public function initialize()
    {
        parent::initialize();
        $this->passCheckService = new PassCheckService();
        $this->setTable((new SellCardOrderModel())->getTable());
//        $this->setValidate(validate(SellCardValidate::class));
    }


    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [
//                ['a.title', 'like', 'keywords'],
//                ['a.cate_id']
            ]);
            $list = $this->passCheckService->getSellCardOrderList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}
