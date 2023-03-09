<?php

//獲取後臺模組當前登錄用戶的資訊
use think\facade\Session;

function get_login_store($key = "")
{
    $session_store = get_config('app.session_store');
    if (Session::has($session_store)) {
        $xuwen_store = Session::get($session_store);
        if (!empty($key)) {
            if (isset($xuwen_store[$key])) {
                return $xuwen_store[$key];
            } else {
                return '';
            }
        } else {
            return $xuwen_store;
        }
    } else {
        return '';
    }
}
