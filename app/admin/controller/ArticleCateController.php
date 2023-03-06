<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\ArticleCateValidate;
use app\exception\RespException;
use app\model\ArticleCateModel;
use app\model\ArticleModel;
use think\Exception;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\View;

class ArticleCateController extends BaseController
{
    private ArticleCateModel $cateModel;

    public function initialize()
    {
        parent::initialize();
        $this->cateModel = new ArticleCateModel();
        $this->setTable($this->cateModel->getTable());
    }


    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->cateModel->getCateList();
            return $this->success('', $list);
        } else {
            return view();
        }
    }

    //获取子分类id.$is_self=1包含自己
    public function get_cate_child($id = 0, $is_self = 1)
    {
        $cate_list = $this->cateModel->getCateList();
        $cates_list = get_data_node($cate_list, $id);
        $cates_array = array_column($cates_list, 'id');
        if ($is_self == 1) {
            //包括自己在内
            $cates_array[] = $id;
        }
        return $cates_array;
    }

    public function add()
    {
        $param = get_param();
        if (request()->isAjax()) {
            try {
                validate(ArticleCateValidate::class)->check($param);
                $id = $this->cateModel->addCate($param);
                add_log('add', $id, $param);
                return $this->success();
            } catch (\Exception $e) {
                return $this->error($e->getMessage());
            }
        } else {
            $pid = $param['pid'] ?? 0;
            View::assign('pid', $pid);
            return view();
        }
    }


    public function edit()
    {
        $param = get_param();
        if (request()->isAjax()) {
            // 检验完整性
            try {
                validate(ArticleCateValidate::class)->check($param);
                $cate_array = $this->get_cate_child($param['id']);
                if (in_array($param['pid'], $cate_array)) {
                    return $this->error('上级分类不能是该分类本身或其子分类');
                }
                $this->cateModel->editCate($param);
                add_log('edit', $param['id'], $param);
                return $this->success();
            } catch (\Exception $e) {
                return $this->error($e->getMessage());
            }
        } else {
            $item = $this->cateModel->find($param['id']);
            View::assign('item', $item);
            return view();
        }
    }

    public function delete()
    {
        $param = get_param();
        try {
            $cate = $this->cateModel->find($param['id']);

            if ($this->cateModel->hasChild($param['id'])) {
                return $this->error('有子分類，不能刪除');
            }

            $article_model = new ArticleModel();
            $article = $article_model->where('cate_id', '=', $param['id'])->find();
            if ($article) {
                return $this->error('分類下有文章，不能刪除');
            }

            $this->cateModel->where('id', $param['id'])->delete();
            add_log('delete', $cate['id'], $cate);
            return $this->success();
        } catch (\Exception $e) {
            return $this->error($e->getMessage());
        }
    }
}
