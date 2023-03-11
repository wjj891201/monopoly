<?php

namespace app\service;

use app\model\BonusPoolModel;


class BonusPoolService
{
    public BonusPoolModel $bonusPoolModel;

    public function __construct()
    {
        $this->bonusPoolModel = new BonusPoolModel();
    }

    public function getBonusPoolList($where = [], $param = [])
    {
        $result = $this->bonusPoolModel->getBonusPoolList($where, $param);
        return $result;
    }
}
