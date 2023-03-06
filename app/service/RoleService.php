<?php

namespace app\service;

use app\model\MemberModel;
use app\model\MemberRoleModel;

class RoleService
{
    public MemberRoleModel $roleModel;
    public MemberModel $memberModel;
    private bool $all;


    private static $instance = null;

    public static function getInstance($all = true)
    {
        if (is_null(self::$instance)) {
            self::$instance = new RoleService($all);
        }
        return self::$instance;
    }

    public function __construct($all = true)
    {
        $this->all = $all;
        $this->roleModel = new MemberRoleModel();
        $this->memberModel = new MemberModel();
    }


    public function getRoleById($id)
    {
        $role = $this->roleModel->find($id);
        return $this->handleRole($role);
    }

    public function getRoleList()
    {
        $where = [];
        if (!$this->all) {
            $where[] = ['status', '=', 1];
        }

        $list = $this->roleModel->where($where)->select();
        foreach ($list as $key => $value) {
            $list[$key] = $this->handleRole($value);
        }
        return $list;
    }


    public function handleRole($item)
    {
        //統計角色用戶數量
        $item['member_count'] = $this->memberModel->countMemberByRole($item['id']);
        return $item;
    }
}
