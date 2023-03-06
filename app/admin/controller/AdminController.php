<?php
declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\model\AdminModel;
use app\admin\validate\AdminDepartmentValidate;
use app\admin\validate\AdminValidate;
use Carbon\Carbon;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\View;

class AdminController extends BaseController
{

    protected function initialize()
    {
        parent::initialize();

        $this->setTable('xw_admin');
        $action = $this->request->action();
        $this->setValidate(validate(AdminValidate::class), $action);
    }

    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = array();
            if (!empty($param['keywords'])) {
                $where[] = ['id|username|nickname|desc|mobile', 'like', '%' . $param['keywords'] . '%'];
            }
            $where[] = ['status', '>=', 0];
            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $list = Db::name('admin')->where($where)
                ->order('created_at asc')
                ->paginate($rows, false, ['query' => $param]);

            foreach ($list as $key => $value) {

                $groupId = Db::name('admin_role_access')->where(['uid' => $value['id']])->column('role_id');
                $groupName = Db::name('admin_role')->where('id', 'in', $groupId)->column('title');
                $value['groupName'] = implode(',', $groupName);
                $list[$key] = $value;
            }
            return $this->apiTable($list);
        } else {
            return view();
        }
    }


    public function initForm($item)
    {
        $department = set_recursion(get_department());
        $position = Db::name('admin_position')->where('status', '>=', 0)->order('created_at asc')->select();
        View::assign('department', $department);
        View::assign('position', $position);

        if (!empty($params['id'])) {
            $item = get_admin($params['id']);
        } else {
            $item = $this->getFields();
            $item['role_id'] = [0];
        }
        return $item;
    }


    public function save($param)
    {
        $param['admin_id'] = get_login_admin('id');
        try {
            if ($this->checkValidate) {
                $this->validate->check($param);
            }

            if (!empty($param['password'])) {
                if ($param['password'] != $param['confirm_password']) {
                    return $this->error('两次密码不一致');
                }
                $param['password'] = create_password($param['password']);
            } else {
                unset($param['password']);
            }

            $param['updated_at'] = Carbon::now()->toDateTimeString();
            if (empty($param['id'])) {
                $param['created_at'] = Carbon::now()->toDateTimeString();
                $id = Db::table($this->table)->strict(false)->field(true)->insertGetId($param);
                add_log('add', $id, $param);
            } else {
                Db::table($this->table)->where(['id' => $param['id']])->strict(false)->field(true)->update($param);
                $id = $param['id'];
                add_log('edit', $param['id'], $param);
            }

            //設置權限

            Db::name('AdminRoleAccess')->where(['uid' => $id])->delete();
            foreach ($param['role_id'] as $k => $v) {
                //为了系统安全，只有系统所有者才可创建id为1的管理员分组
                if ($v == 1 and get_login_admin('id') !== 1) {
                    throw new ValidateException("你没有权限创建系统所有者", 1);
                }
                $roleData[$k] = [
                    'uid' => $id,
                    'role_id' => $v,
                ];
            }
            Db::name('AdminRoleAccess')->strict(false)->field(true)->insertAll($roleData);


            //清除菜单\权限缓存
            clear_cache('adminMenu');
            clear_cache('adminRules');


            return $this->success();
        } catch (\Exception $e) {
            return $this->error($e->getMessage());
        }
    }


    //删除
    public function delete()
    {
        $id = get_param('id');
        if ($id == 1) {
            return $this->success('超级管理员，不能删除');
        }
        return parent::delete();
    }

    //管理员操作日志
    public function log()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = array();
            if (!empty($param['keywords'])) {
                $where[] = ['nickname|rule_menu|item_id', 'like', '%' . $param['keywords'] . '%'];
            }
            if (!empty($param['title_cate'])) {
                $where['title'] = $param['title_cate'];
            }
            if (!empty($param['rule_menu'])) {
                $where['rule_menu'] = $param['rule_menu'];
            }
            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $content = DB::name('admin_log')
                ->field('id,uid,nickname,title,content,rule_menu,ip,item_id,param')
                ->order('created_at desc')
                ->where($where)
                ->paginate($rows, false, ['query' => $param]);
            $content->toArray();
            foreach ($content as $k => $v) {
                $data = $v;
                $param_array = json_decode($v['param'], true);
                if (is_array($param_array)) {
                    $param_value = '';
                    foreach ($param_array as $key => $value) {
                        if (is_array($value)) {
                            $value = implode(',', $value);
                        }
                        $param_value .= $key . ':' . $value . '&nbsp;&nbsp;|&nbsp;&nbsp;';
                    }
                    $data['param'] = $param_value;
                } else {
                    $data['param'] = $param_array;
                }
                $content->offsetSet($k, $data);
            }
            return $this->apiTable($content);
        } else {
            return view();
        }
    }
}
