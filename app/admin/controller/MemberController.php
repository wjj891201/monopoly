<?php

namespace app\admin\controller;

use app\admin\BaseController;
use app\model\MemberModel;
use app\model\MemberRoleModel;
use think\facade\Db;
use think\facade\View;

class MemberController extends BaseController
{
    private MemberModel $memberModel;

    protected function initialize()
    {
        parent::initialize();
        $this->memberModel = new MemberModel();
        $this->setTable($this->memberModel->getTable());
    }

    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();

            $where = search_where($param, [
                ['username|email', 'like', 'keywords'],
            ]);

            $dataWhere = search_date($param, 'm.created_at');

            $where = array_merge($where, $dataWhere);
            $result = $this->memberModel->getMemberList($where, $param);
            foreach ($result as $key => $value) {
                if ($value['pid']) {
                    $parent = $this->memberModel->getMemberByID($value['pid']);
                    $value['parent_name'] = $parent['username'];
                    $value['parent_email'] = $parent['email'];
                    $value['parent_role_name'] = $parent['role_name'];
                }
                $result[$key] = $value;
            }
            return $this->apiTable($result);
        } else {
            return view();
        }
    }


    public function initForm($item)
    {
        $roleList = (new MemberRoleModel())->select()->toArray();
        View::assign('role_list', $roleList);

        return $item;
    }


    public function log()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = array();
            if (!empty($param['keywords'])) {
                $where[] = ['username|content|item_id', 'like', '%' . $param['keywords'] . '%'];
            }
            if (!empty($param['action'])) {
                $where[] = ['title', '=', $param['action']];
            }

            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $content = DB::name('member_log')
                ->field('id,member_id,username,title,content,ip,item_id,param,created_at')
                ->order('created_at desc')
                ->where($where)
                ->paginate($rows, false, ['query' => $param]);

            $content->toArray();
            foreach ($content as $k => $v) {
                $data = $v;
                $param_array = json_decode($v['param'], true);
                $param_value = '';
                foreach ($param_array as $key => $value) {
                    // if (is_array($value)) {
                    //     $value = array_to_string($value);
                    // }
                    $param_value .= $key . ':' . $value . '&nbsp;&nbsp;|&nbsp;&nbsp;';
                }
                $data['param'] = $param_value;
                $content->offsetSet($k, $data);
            }
            return $this->apiTable($content);
        } else {
            $type_action = get_config('log.user_action');
            View::assign('type_action', $type_action);
            return view();
        }
    }
}
