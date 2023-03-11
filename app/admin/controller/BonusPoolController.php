<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\BonusPoolModel;
use app\service\BonusPoolService;
use app\admin\validate\BonusPoolValidate;
use think\facade\View;

class BonusPoolController extends BaseController
{

    private BonusPoolService $bonusPoolService;

    public function initialize()
    {
        parent::initialize();
        $this->bonusPoolService = new BonusPoolService();
        $this->setTable((new BonusPoolModel())->getTable());
        $this->setValidate(validate(BonusPoolValidate::class));
    }

    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = search_where($param, [
//                ['a.title', 'like', 'keywords'],
//                ['o.cate_id']
            ]);
            $list = $this->bonusPoolService->getBonusPoolList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}
