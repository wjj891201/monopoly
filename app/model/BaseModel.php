<?php

namespace app\model;

use think\facade\Db;
use think\Model;

class BaseModel extends Model
{

    public function __construct(array $data = [])
    {
        $this->table = $this->getTable($this->table);
        parent::__construct($data);
    }

    public function getFields()
    {
        $fields = Db::getTableFields($this->table);
        $data = [];
        foreach ($fields as $value) {
            $data[$value] = '';
        }
        return $data;
    }
}