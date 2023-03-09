<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;

use app\admin\validate\PageValidate;
use app\model\PageModel;

class PageController extends BaseController
{
    private PageModel $pageModel;


    public function initialize()
    {
        parent::initialize();
        $this->pageModel = new PageModel();
        $this->setTable($this->pageModel->getTable());
        $this->setValidate(validate(PageValidate::class));
    }


    public function index()
    {
        $param = get_param();
        if (request()->isAjax()) {

            $where = search_where($param,[
                ['title', 'like', 'keywords'],
            ]);

            $list = $this->pageModel->getPageList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

}
