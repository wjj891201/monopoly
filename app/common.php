<?php

// 应用公共文件
use Carbon\Carbon;
use think\facade\Cache;
use think\facade\Config;
use think\facade\Db;
use think\facade\Request;
use think\facade\Session;


//设置缓存
function set_cache($key, $value, $date = 86400)
{
    Cache::set($key, $value, $date);
}

//读取缓存
function get_cache($key)
{
    return Cache::get($key);
}

//清空缓存
function clear_cache($key)
{
    Cache::clear($key);
}


//读取文件配置
function get_config($key)
{
    return Config::get($key);
}

//读取系统配置
function get_system_config($name, $key = '')
{
    $config = [];
    if (get_cache('system_config' . $name)) {
        $config = get_cache('system_config' . $name);
    } else {
        $conf = Db::name('config')->where('name', $name)->find();
        if ($conf['content']) {
            $config = unserialize($conf['content']);
        }
        set_cache('system_config' . $name, $config);
    }
    if ($key == '') {
        return $config;
    } else {
        if (isset($config[$key]) && $config[$key]) {
            return $config[$key];
        }
    }
}

//系统信息
function get_system_info($key)
{
    $system = [
        'os' => PHP_OS,
        'php' => PHP_VERSION,
        'upload_max_filesize' => get_cfg_var("upload_max_filesize") ? get_cfg_var("upload_max_filesize") : "不允许上传附件",
        'max_execution_time' => get_cfg_var("max_execution_time") . "秒 ",
    ];
    if (empty($key)) {
        return $system;
    } else {
        return $system[$key];
    }
}

//获取url参数
function get_param($key = "")
{
    $params = Request::instance()->param($key);


    return $params;
}

//生成一个不会重复的字符串
function make_token()
{
    $str = md5(uniqid(md5(microtime(true)), true));
    $str = sha1($str); //加密
    return $str;
}

//随机字符串，默认长度10
function set_salt($num = 10)
{
    $str = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890';
    $salt = substr(str_shuffle($str), 10, $num);
    return $salt;
}

//密码加密
function create_password($pwd)
{
    return md5($pwd);
}


//菜单转为父子菜单
function list_to_tree($list, $pk = 'id', $pid = 'pid', $child = 'list', $root = 0)
{
    // 创建Tree
    $tree = array();
    if (is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] = &$list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId = $data[$pid];
            if ($root == $parentId) {
                $tree[$data[$pk]] = &$list[$key];
            } else {
                if (isset($refer[$parentId])) {
                    $parent = &$refer[$parentId];
                    $parent[$child][$data[$pk]] = &$list[$key];
                }
            }
        }
    }
    return $tree;
}


/**
 * 根据附件表的id返回url地址
 * @param  [type] $id [description]
 */
function get_file($id)
{

    $domain = Config::get('filesystem.url');

    if ($id) {
        $geturl = Db::name("file")->where(['id' => $id])->find();
        if ($geturl['status'] == 1) {
            //审核通过
            //获取签名的URL
            $url = $geturl['filepath'];
            return $domain . $url;
        } elseif ($geturl['status'] == 0) {
            //待审核
            return '/static/admin/images/nonepic360x360.jpg';
        } else {
            //不通过
            return '/static/admin/images/nonepic360x360.jpg';
        }
    }
    return false;
}

function get_file_list($dir)
{
    $list = [];
    if (is_dir($dir)) {
        $info = opendir($dir);
        while (($file = readdir($info)) !== false) {
            //echo $file.'<br>';
            $pathinfo = pathinfo($file);
            if ($pathinfo['extension'] == 'html') {   //只获取符合后缀的文件
                array_push($list, $pathinfo);
            }
        }
        closedir($info);
    }
    return $list;
}

//获取当前登录用户的信息
function get_login_user($key = "")
{
    $session_user = get_config('app.session_user');
    if (Session::has($session_user)) {
        $xuwen_user = Session::get($session_user);
        if (!empty($key)) {
            if (isset($xuwen_user[$key])) {
                return $xuwen_user[$key];
            } else {
                return '';
            }
        } else {
            return $xuwen_user;
        }
    } else {
        return '';
    }
}

/**
 * 判断访客是否是蜘蛛
 */
function isRobot($except = '')
{
    $ua = strtolower($_SERVER['HTTP_USER_AGENT']);
    $botchar = "/(baidu|google|spider|soso|yahoo|sohu-search|yodao|robozilla|AhrefsBot)/i";
    $except ? $botchar = str_replace($except . '|', '', $botchar) : '';
    if (preg_match($botchar, $ua)) {
        return true;
    }
    return false;
}


/*
* 下划线转驼峰
* 思路:
* step1.原字符串转小写,原字符串中的分隔符用空格替换,在字符串开头加上分隔符
* step2.将字符串中每个单词的首字母转换为大写,再去空格,去字符串首部附加的分隔符.
*/
function camelize($uncamelized_words, $separator = '_')
{
    $uncamelized_words = $separator . str_replace($separator, " ", strtolower($uncamelized_words));
    return ltrim(str_replace(" ", "", ucwords($uncamelized_words)), $separator);
}

/**
 * 驼峰命名转下划线命名
 * 思路:
 * 小写和大写紧挨一起的地方,加上分隔符,然后全部转小写
 */
function uncamelize($camelCaps, $separator = '_')
{
    return strtolower(preg_replace('/([a-z])([A-Z])/', "$1" . $separator . "$2", $camelCaps));
}


function api_return($data, int $code = 0, $msg = '', $httpCode = 200, array $header = [])
{
    $result = [
        'code' => $code,
        'msg' => $msg,
        'time' => Carbon::now()->toDateTimeString(),
        'data' => $data,
    ];
    return json($result, $httpCode, $header);
}
