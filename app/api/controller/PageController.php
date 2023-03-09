<?php

namespace app\api\controller;

use app\api\BaseController;
use app\exception\RespException;
use app\model\PageModel;
use app\validate\CommonValidate;

class PageController extends BaseController
{
    private PageModel $pageModel;


    public function initialize()
    {
        parent::initialize();
        $this->pageModel = new PageModel();
    }

    public function info()
    {
        $param = get_param();
        if (empty($param['id'])) {
            return $this->apiError('参数错误');
        }
        $item = $this->pageModel->find($param['id']);
        if (empty($item) || $item['status'] == 0) {
            return $this->apiError('数据不存在');
        }
        $this->apiData($item);
    }
}