<?php

namespace app\api\controller;

use app\api\BaseController;
use app\exception\RespException;
use app\service\ArticleService;
use app\validate\CommonValidate;

class ArticleController extends BaseController
{
    protected ArticleService $articleService;

    public function initialize()
    {
        parent::initialize();
        $this->articleService = ArticleService::getInstance(false);
    }


    public function cates()
    {
        $pid = get_param('pid');
        $list = $this->articleService->cateModel->getCateList([['pid', '=', $pid], ['status', '=', 1]]);
        return $this->apiData($list);
    }

    public function list()
    {
        $param = get_param();
        $where = [['a.status', '=', 1]];
        if (!empty($param['cate_id'])) {
            $where[] = ['a.cate_id', '=', $param['cate_id']];
        }
        $list = $this->articleService->getArticleList($where, $param);
        return $this->apiData($list);
    }

    public function info()
    {
        $param = get_param();
        if (empty($param['id'])) {
            return $this->apiError('参数错误');
        }
        $item = $this->articleService->getArticleById($param['id']);
        if (empty($item) || $item['status'] == 0) {
            return $this->apiError('数据不存在');
        }
        $this->apiData($item);
    }
}
