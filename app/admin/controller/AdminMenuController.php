<?php


declare(strict_types=1);

namespace app\admin\controller;

use Carbon\Carbon;
use think\facade\Db;
use think\facade\View;
use app\admin\BaseController;
use think\exception\ValidateException;
use app\admin\validate\AdminMenuValidate;

class AdminMenuController extends BaseController
{
    protected function initialize()
    {
        parent::initialize();
        $this->setTable('xw_admin_menu');
        $action = $this->request->action();
        $this->setValidate(validate(AdminMenuValidate::class), $action);
    }


    public function index()
    {
        if (request()->isAjax()) {
            $rule = Db::name('admin_menu')->order('sort_order asc,id asc')->select();
            return $this->success('', $rule);
        } else {
            return view();
        }
    }

    public function save($param)
    {
        try {
            $param['src'] = preg_replace('# #', '', $param['src']);
            parent::save($param);
            clear_cache('admin_menu');
            return $this->success();
        } catch (\Exception $e) {
            return $this->error($e->getMessage());
        }
    }

    //删除
    public function delete()
    {
        $id = get_param('id');
        $count = Db::name('admin_menu')->where(['pid' => $id])->count();
        if ($count > 0) {
            return $this->error('该节点下还有子节点，无法删除');
        }
        clear_cache('admin_menu');

        return parent::delete();
    }
}
