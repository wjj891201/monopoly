<?php

namespace app\service;

use app\exception\RespException;
use Carbon\Carbon;
use think\facade\Db;

class TaskService
{

    private static $instance = null;

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new TaskService();
        }
        return self::$instance;
    }



    public function getTodayTask($key)
    {
        //驗證是否處理過數據
        $startToday = Carbon::now()->startOfDay()->toDateTimeString();
        $endToday = Carbon::now()->endOfDay()->toDateTimeString();
        $where = [
            ['item', '=', $key],
            ['created_at', '>=', $startToday],
            ['created_at', '<=', $endToday],
        ];
        return Db::name('task_log')->where($where)->order('id', 'desc')->find();
    }

    public function checkTask($key)
    {
        $log = $this->getTodayTask($key);
        if (!empty($log)) {
            throw new RespException(1, '今天已處理');
        }

        $logData = [
            'item' => $key,
            'created_at' => Carbon::now()->toDateTimeString()
        ];
        Db::name('task_log')->insertGetId($logData);
        return true;
    }

    public function finishTaskByKey($key, $param)
    {
        $task = $this->getTodayTask($key);
        if (empty($task)) {
            throw new RespException(1, '任务不存在');
        }

        Db::name('task_log')->where('id', $task['id'])->update([
            'finished_at' => Carbon::now()->toDateTimeString(),
            'content' => serialize($param)
        ]);
        return true;
    }
}
