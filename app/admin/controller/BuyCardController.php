<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\BuyCardValidate;
use app\service\PassCheckService;
use app\model\BuyCardModel;
use app\exception\RespException;


class BuyCardController extends BaseController
{
    private PassCheckService $passCheckService;

    public function initialize()
    {
        parent::initialize();
        $this->passCheckService = new PassCheckService();
        $this->setTable((new BuyCardModel())->getTable());
        $this->setValidate(validate(BuyCardValidate::class));
    }


    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [
//                ['a.title', 'like', 'keywords'],
//                ['a.cate_id']
            ]);
            $list = $this->passCheckService->getBuyCardList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}
