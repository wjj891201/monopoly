<?php

namespace app\service;

use think\facade\Db;

class TeamService
{

    private static $instance = null;

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new TeamService();
        }
        return self::$instance;
    }

    //todo 从缓存读取
    public function getAllMember()
    {
        $memberList = Db::name('member')->where('status', 1)->select()->toArray();
        return $memberList;
    }

    public function getMember($id)
    {
        $allMember = $this->getAllMember();
        foreach ($allMember as $value) {
            if ($value['id'] == $id) {
                return $value;
            }
        }
        return [];
    }

    public function getDirectList($id)
    {
        $memberList = $this->getAllMember();
        $directList = [];
        foreach ($memberList as $value) {
            if ($value['pid'] == $id && $value['role_id'] > 0) {
                $role = $this->getRole($value['role_id']);
                $value['role_name'] = $role['name'];
                $directList[] = $value;
            }
        }
        return $directList;
    }

    //todo 从缓存读取
    public function getAllRole()
    {
        $roleList = Db::name('member_role')->where('status', 1)->select()->toArray();
        return $roleList;
    }

    public function getRole($id)
    {
        $allRole = $this->getAllRole();
        foreach ($allRole as $value) {
            if ($value['id'] == $id) {
                return $value;
            }
        }
        return [];
    }


    //上级查询
    public function getParentList($id, $parentList = [])
    {
        $member = $this->getMember($id);
        if ($member['pid']) {
            $parent = $this->getMember($member['pid']);
            $parentList[] = $parent;
            if ($parent['pid']) {
                return $this->getParentList($parent['id'], $parentList);
            }
        }
        return $parentList;
    }

    public function getChildList($id, $childList = [])
    {
        $cList = [];
        foreach ($childList as $key => $value) {
            if ($value['pid'] == $id) {
                $child = $this->getChildList($value['id'], $childList);
                $cList[] = $child;
                if (!empty($child)) {
                    $cList = array_merge($cList, $child);
                }
            }
        }
        return $cList;
    }
}
