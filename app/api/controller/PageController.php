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
        try {
            $param = get_param();
            validate(CommonValidate::class)->scene("id")->check($param);

            $item = $this->pageModel->find($param['id']);

            if (empty($item) || $item['status'] == 0) {
                throw new RespException(1, '數據不存在');
            }
            return $this->apiData($item);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}