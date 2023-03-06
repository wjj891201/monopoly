<?php

declare(strict_types=1);

namespace app\facade;

use app\exception\RespException;
use NinjaMutex\Lock\PhpRedisLock;
use NinjaMutex\Mutex;
use think\Facade;
use think\facade\Cache;
use think\facade\Config;

class MutexFacade extends Facade
{
    public static function create($key)
    {
        $lockKey = Config::get('mutex.key.' . $key);
        if (!$lockKey) {
            throw new RespException(1, 'mutex key不存在');
        }

        $redis = Cache::store('redis')->handler();
        $lock = new PhpRedisLock($redis);
        $prefix = Config::get('mutex.prefix');

        $mutex = new Mutex($prefix . $lockKey, $lock);
        if ($mutex->isLocked()) {
            throw new RespException(1, '系統繁忙請重試');
        }
        return $mutex;
    }
}
