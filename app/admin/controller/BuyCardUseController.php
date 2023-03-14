<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\service\PassCheckService;
use app\model\BuyCardUseModel;
use app\exception\RespException;


class BuyCardUseController extends BaseController
{
    private PassCheckService $passCheckService;

    public function initialize()
    {
        parent::initialize();
        $this->passCheckService = new PassCheckService();
        $this->setTable((new BuyCardUseModel())->getTable());
    }


    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [

            ]);
            $list = $this->passCheckService->getBuyCardUseList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}
