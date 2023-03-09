<?php


declare(strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\RoleValidate;
use app\model\MemberRoleModel;
use app\service\RoleService;

class RoleController extends BaseController
{

    private RoleService $roleService;

    protected function initialize()
    {
        parent::initialize();
        $this->roleService = new RoleService();
        $this->setTable((new MemberRoleModel())->getTable());
        $this->setValidate(validate(RoleValidate::class));
    }

    public function index()
    {
        if (request()->isAjax()) {
            $list = $this->roleService->getRoleList();
            return $this->success('', $list);
        } else {
            return view();
        }
    }

}
