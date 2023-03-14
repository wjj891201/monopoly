<?php

use Carbon\Carbon;
use think\facade\Db;


/**
 * 客户操作日志
 * @param string $type 操作类型 login register add edit view delete down join sign play order pay
 * @param string $item 操作内容
 * @param int $itemId 操作内容id
 * @param array $param 提交的参数
 */
function add_user_log($type, $item = '', $itemId = 0, $param = [])
{
    $title = '未知操作';
    $type_action = get_config('log.user_action');
    if ($type_action[$type]) {
        $title = $type_action[$type];
    }

    if ($type == 'login' || $type == "register") {
        $login_user = Db::name('member')->where(array('id' => $itemId))->find();
    } else {
        $memberId = $param["member_id"] ?? 0;
        $login_user = Db::name('member')->where(array('id' => $memberId))->find();
        if (empty($login_user)) {
            $login_user = [];
            $login_user['id'] = 0;
            $login_user['username'] = '遊客';
            if (isRobot()) {
                $login_user['username'] = '蜘蛛';
                $type = 'spider';
                $title = '爬行';
            }
        }
    }
    $content = $login_user['username'] . '在' . date('Y-m-d H:i:s') . '执行了' . $title . '操作';
    if ($item != '') {
        $content = $login_user['username'] . '在' . date('Y-m-d H:i:s') . $title . '了' . $item;
    }
    $data = [];
    $data['member_id'] = $login_user['id'];
    $data['username'] = $login_user['username'];
    $data['type'] = $type;
    $data['title'] = $title;
    $data['content'] = $content;
    $data['item_id'] = $itemId;
    $data['param'] = json_encode($param);
    $data['module'] = strtolower(app('http')->getName());
    $data['controller'] = strtolower(app('request')->controller());
    $data['function'] = strtolower(app('request')->action());
    $data['ip'] = app('request')->ip();
    $data['created_at'] = Carbon::now()->toDateTimeString();
    Db::name('member_log')->strict(false)->field(true)->insert($data);
}
