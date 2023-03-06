<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\ArticleValidate;
use app\model\ArticleModel;
use app\service\ArticleService;
use think\facade\View;

class ArticleController extends BaseController
{

    private ArticleService $articleService;

    public function initialize()
    {
        parent::initialize();
        $this->articleService = new ArticleService();
        $this->setTable((new ArticleModel())->getTable());
        $this->setValidate(validate(ArticleValidate::class));
    }

    public function index()
    {
        $param = get_param();

        if (request()->isAjax()) {
            $where = [];
            if (!empty($param['keywords'])) {
                $where[] = ['a.title', 'like', '%' . $param['keywords'] . '%'];
            }
            if (!empty($param['cate_id'])) {
                $where[] = ['a.cate_id', '=', $param['cate_id']];
            }
            $list = $this->articleService->getArticleList($where, $param);
            return $this->apiTable($list);
        } else {
            return view();
        }
    }

    public function initForm($item)
    {
        View::assign("type_list", $this->articleService->getTypeList());
        return $item;
    }

}
