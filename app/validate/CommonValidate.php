<?php

namespace app\validate;

use app\BaseValidate;

class CommonValidate extends BaseValidate
{
    protected $rule = [
        'id' => 'require',
    ];

    protected $message = [
        'id.require' => '參數不正確',
        'id.checkStatus' => '數據不存在',
    ];

    protected $scene = [
        'id' => ['id'],
        'status' => ['id']
    ];

    protected function sceneStatus()
    {
        return $this->append('id', 'checkStatus');
    }
}