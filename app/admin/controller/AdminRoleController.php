<?php


declare(strict_types=1);

namespace app\admin\controller;

use app\admin\validate\AdminRoleValidate;
use think\facade\Db;
use think\facade\View;
use app\admin\BaseController;
use app\admin\model\AdminRoleModel;


class AdminRoleController extends BaseController
{
    protected function initialize()
    {
        parent::initialize();
        $this->setTable('xw_admin_role');
        $action = $this->request->action();
        $this->setValidate(validate(AdminRoleValidate::class), $action);
    }

    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = array();
            if (!empty($param['keywords'])) {
                $where[] = ['id|title|desc', 'like', '%' . $param['keywords'] . '%'];
            }
            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $group = AdminRoleModel::where($where)
                ->order('created_at asc')
                ->paginate($rows, false, ['query' => $param]);
            return $this->apiTable($group);
        } else {
            return view();
        }
    }


    public function initForm($item)
    {
        $menu = get_admin_menu();
        if ($item['id'] > 0) {
            //讀取指定許可權分組詳情
            $rules = Db::name('admin_role')->where(['id' => $item['id']])->value('rules');
            $rules = explode(',', $rules);

            $role_rule = create_tree_list(0, $menu, $rules);
            $role = get_admin_role();
            View::assign('role', $role);
        } else {
            $role_rule = create_tree_list(0, $menu, []);
        }
        View::assign('role_rule', $role_rule);
        View::assign('id', $item['id']);
        return $item;
    }


    public function save($param)
    {
        $ruleData = $param['rule'] ?? 0;
        $param['rules'] = implode(',', $ruleData);
        clear_cache('adminMenu');

        return parent::save($param);
    }

    public function delete()
    {
        $id = get_param('id');
        if ($id == 1) {
            return $this->error('該組是系統所有者，無法刪除');
        }

        return parent::delete();
    }
}
