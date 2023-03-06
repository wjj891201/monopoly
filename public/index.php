<?php


// [ 应用入口文件 ]
namespace think;

// 添加允许跨域请求头
header("'Access-Control-Allow-Credentials: true");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Authorization, Content-Type, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, X-CSRF-TOKEN, X-Requested-With, X-Token,X-Lang,X-User-ID,X-Client-ID");
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS, PATCH');

// 处理 OPTIONS 请求
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
    exit;
}


if (empty(file_exists(__DIR__ . '/../vendor/autoload.php'))) {
    echo '您还未安装PHP依赖包，请输入命令安装：composer install';
    exit;
}
require __DIR__ . '/../vendor/autoload.php';

// 定义当前版本号
define('CMS_VERSION','1.0.0');

// 定义Layui版本号
define('LAYUI_VERSION','2.7.6');

// 定义项目目录
define('CMS_ROOT', __DIR__ . '/../');

// 执行HTTP应用并响应
$http = (new App())->http;

$response = $http->run();

$response->send();

$http->end($response);
