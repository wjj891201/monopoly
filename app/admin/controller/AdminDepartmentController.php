<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\AdminDepartmentValidate;
use Carbon\Carbon;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\View;

class AdminDepartmentController extends BaseController
{

    protected function initialize()
    {
        parent::initialize();

        $this->setTable('xw_admin_department');
        $action = $this->request->action();
        $this->setValidate(validate(AdminDepartmentValidate::class), $action);
    }

    public function index()
    {
        if (request()->isAjax()) {
            $list = Db::name('admin_department')
                ->field('d.*,a.nickname as leader')
                ->alias('d')
                ->join('admin a', 'a.id = d.leader_id', 'LEFT')
                ->order('d.id asc')
                ->select();
            return $this->success('', $list);
        } else {
            return view();
        }
    }

    public function initForm($item)
    {
        $param = get_param();
        $id = $param['id'] ?? 0;
        $pid = $param['pid'] ?? 0;
        $department = set_recursion(get_department());
        $users = Db::name('admin')->where(['did' => $id, 'status' => 1])->select();
        View::assign('users', $users);
        View::assign('department', $department);
        View::assign('pid', $pid);
        View::assign('id', $id);
    }

    public function save($param)
    {
        $department_array = get_department_son($param['id']);
        if (in_array($param['pid'], $department_array)) {
            return $this->error('上級部門不能是該部門本身或其下屬部門');
        }
        return parent::save($param);
    }



    //刪除
    public function delete()
    {
        $id = get_param('id');
        $count = Db::name('admin_department')->where([['pid', '=', $id], ['status', '>=', 0]])->count();
        if ($count > 0) {
            return $this->error('該部門下還有子部門，無法刪除');
        }
        $users = Db::name('admin')->where([['did', '=', $id], ['status', '>=', 0]])->count();
        if ($users > 0) {
            return $this->error('該部門下還有員工，無法刪除');
        }
        return parent::delete();
    }
}
