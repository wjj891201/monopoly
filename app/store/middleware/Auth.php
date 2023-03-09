<?php


declare (strict_types=1);

namespace app\store\middleware;

use think\facade\Cache;
use think\facade\Db;
use think\facade\Session;

class Auth
{
    public function handle($request, \Closure $next)
    {
        $pathInfo = str_replace('.' . $request->ext(), '', $request->pathInfo());
        $action = explode('/', $pathInfo)[0];
        if ($pathInfo == '' || $action == '') {
            redirect('/store/index/index')->send();
            exit;
        }
        //驗證用戶登錄
        if ($action !== 'login') {
            $session_store = get_config('app.session_store');
            if (!Session::has($session_store)) {
                if ($request->isAjax()) {
                    return api_return([], 404, '請先登入');
                } else {
                    redirect('/store/login/index')->send();
                    exit;
                }
            }
        }
        return $next($request);
    }
}
