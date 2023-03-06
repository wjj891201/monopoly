<?php


declare(strict_types=1);

namespace app\admin\controller;

use Carbon\Carbon;
use think\facade\Db;
use think\facade\View;
use app\admin\BaseController;
use think\exception\ValidateException;
use app\admin\validate\AdminPositionValidate;
use app\admin\validate\AdminDepartmentValidate;

class AdminPositionController extends BaseController
{

    protected function initialize()
    {
        parent::initialize();

        $this->setTable('xw_admin_position');
        $action = $this->request->action();
        $this->setValidate(validate(AdminPositionValidate::class), $action);
    }

    public function index()
    {
        if (request()->isAjax()) {
            $list = Db::name('admin_position')->where('status', '>=', 0)->order('created_at asc')->select()->toArray();
            $res['data'] = $list;
            return $this->apiTable($res);
        } else {
            return view();
        }
    }

    //刪除
    public function delete()
    {
        $id = get_param('id');
        if ($id == 1) {
            return $this->success('超級崗位，不能刪除');
        }
        return parent::delete();
    }
}
