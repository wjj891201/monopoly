<?php

namespace app\service;

use app\model\ArticleCateModel;
use app\model\ArticleModel;
use think\facade\Config;

class ArticleService
{
    public ArticleModel $articleModel;
    public ArticleCateModel $cateModel;
    private bool $all;
    private array $typeList = ['普通', '推薦1', '推薦2', '推薦3', '推薦4', '推薦5', '推薦6', '推薦7', '推薦8', '推薦9', '推薦10'];

    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new ArticleService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->cateModel = new ArticleCateModel();
        $this->articleModel = new ArticleModel();
    }

    public function getTypeList()
    {
        return $this->typeList;
    }

    public function getArticleById($id)
    {
        $item = $this->articleModel->find($id);
        if (empty($item)) {
            return [];
        }
        $item = $this->handleData($item);
        return $item;
    }

    public function getArticleList($where = [], $param = [])
    {
        $result = $this->articleModel->getArticleList($where, $param);
        foreach ($result as $key => $value) {
            $result[$key] = $this->handleData($value);
        }
        return $result;
    }


    public function handleData($item)
    {
        if (!$this->all) {
            unset($item['admin_id'], $item['status'], $item['admin_name']);
        }
        $item["type_name"] = $this->typeList[$item["type"]];
        if (!empty($item['image'])) {
            $item['image_url'] = get_file($item['image']);
        }

        //替換文章內容路徑
        $domain = Config::get('filesystem.url');
        $replaceStr = 'src="' . $domain . '/storage';
        $item['content'] = str_replace('src="/storage', $replaceStr, $item['content']);

        return $item;
    }
}
