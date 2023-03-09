<?php

namespace app\api\controller;

use app\api\BaseController;
use app\exception\RespException;
use app\model\DappModel;
use app\validate\CommonValidate;

class DappController extends BaseController
{
    protected DappModel $dappModel;

    public function initialize()
    {
        parent::initialize();
        $this->dappModel = new DappModel();
    }

    public function list()
    {
        $lang = $this->param['lang'] ?? 'tw';
        $where = [
            ['status', '=', 1],
            ['lang', '=', $lang]
        ];
        if (isset($this->param['is_recommend'])) {
            $where[] = ['is_recommend', '=', 1];
        }
        $list = $this->dappModel->getDappList($where);
        return $this->apiData($list);
    }

    public function info()
    {

        $param = get_param();
        if (empty($param['id'])) {
            return $this->apiError('参数错误');
        }
        $item = $this->dappModel->find($param['id']);
        if (empty($item) || $item['status'] == 0) {
            $this->apiError('數據不存在');
        }
        return $this->apiData($item);
    }
}
