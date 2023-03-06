<?php


declare (strict_types=1);

namespace app\admin;

use Carbon\Carbon;
use think\App;
use think\facade\Db;
use think\Validate;
use think\facade\View;
use think\Model;
use think\Response;

/**
 * 控制器基础类
 */
abstract class BaseController
{


    /**
     * Request实例
     * @var \think\Request
     */
    protected $request;

    /**
     * 应用实例
     * @var \think\App
     */
    protected $app;

    /**
     * 是否批量验证
     * @var bool
     */
    protected $batchValidate = false;

    /**
     * 控制器中间件
     * @var array
     */
    protected $middleware = [];


    protected $param;

    protected $mutexConfig;

    protected string $table;

    protected Validate $validate;

    protected bool $checkValidate = false;

    /**
     * 构造方法
     * @access public
     * @param App $app 应用对象
     */
    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $this->app->request;

        // 控制器初始化
        $this->initialize();
    }

    // 初始化
    protected function initialize()
    {
        $this->param = $this->request->param();
    }


    /**
     * 适配layui数据列表的返回数据方法，用于接口
     */
    public function apiTable($data = [], $httpCode = 200, $header = [], $options = [])
    {
        $res['code'] = 0;
        $res['msg'] = "請求成功";
        if (is_object($data)) {
            $data = $data->toArray();
        }
        if (!empty($data['total'])) {
            $res['count'] = $data['total'];
        } else {
            $res['count'] = 0;
        }
        $res['data'] = $data['data'];
        return json($res, $httpCode, $header, $options);
    }

    /**
     * 操作成功跳转的快捷方法
     * @access protected
     * @param mixed $msg 提示信息
     * @param string $url 跳转的URL地址
     * @param mixed $data 返回的数据
     * @param integer $wait 跳转等待时间
     * @param array $header 发送的Header信息
     */
    protected function success($msg = '操作成功', $data = '', string $url = null, int $wait = 3, array $header = [])
    {
        if (is_null($url) && isset($_SERVER["HTTP_REFERER"])) {
            $url = $_SERVER["HTTP_REFERER"];
        } elseif ($url) {
            $url = (strpos($url, '://') || 0 === strpos($url, '/')) ? $url : app('route')->buildUrl($url);
        }

        $result = [
            'code' => 0,
            'msg' => $msg,
            'data' => $data,
            'url' => $url,
            'wait' => $wait,
        ];

        $type = $this->getResponseType();
        if ($type == 'html') {
            $response = view($this->app->config->get('app.dispatch_success_tmpl'), $result);
        } else if ($type == 'json') {
            $response = json($result);
        }
        return $response;
    }

    /**
     * 操作错误跳转的快捷方法
     * @access protected
     * @param mixed $msg 提示信息
     * @param string $url 跳转的URL地址
     * @param mixed $data 返回的数据
     * @param integer $wait 跳转等待时间
     * @param array $header 发送的Header信息
     */
    protected function error($msg = '', string $url = null, $data = '', int $wait = 3, array $header = [])
    {
        if (is_null($url)) {
            $url = $this->request->isAjax() ? '' : 'javascript:history.back(-1);';
        } elseif ($url) {
            $url = (strpos($url, '://') || 0 === strpos($url, '/')) ? $url : $this->app->route->buildUrl($url);
        }

        $result = [
            'code' => 1,
            'msg' => $msg,
            'data' => $data,
            'url' => $url,
            'wait' => $wait,
        ];

        $type = $this->getResponseType();
        if ($type == 'html') {
            $response = view($this->app->config->get('app.dispatch_error_tmpl'), $result);
        } else if ($type == 'json') {
            $response = json($result);
        }
        return $response;
    }

    /**
     * URL重定向  自带重定向无效
     * @access protected
     * @param string $url 跳转的URL表达式
     * @param array|integer $params 其它URL参数
     * @param integer $code http code
     * @param array $with 隐式传参
     */
    protected function redirect($url, $params = [], $code = 302, $with = [])
    {
        $response = Response::create($url, 'redirect');

        if (is_integer($params)) {
            $code = $params;
            $params = [];
        }

        $response->code($code)->params($params)->with($with);

        return $response;
    }

    /**
     * 获取当前的response 输出类型
     * @access protected
     * @return string
     */
    protected function getResponseType()
    {
        return $this->request->isJson() || $this->request->isAjax() ? 'json' : 'html';
    }

    protected function searchDate($param, $field = 'created_at')
    {
        $where = [];
        $start_time = $param['start_time'] ?? 0;
        $end_time = $param['end_time'] ?? 0;

        if ($start_time > 0 && $end_time > 0) {
            if ($start_time === $end_time) {
                $where[] = [$field, '=', $start_time];
            } else {
                $where[] = [$field, '>=', $start_time];
                $where[] = [$field, '<=', $end_time];
            }
        } elseif ($start_time > 0 && $end_time == 0) {
            $where[] = [$field, '>=', $start_time];
        } elseif ($start_time == 0 && $end_time > 0) {
            $where[] = [$field, '<=', $end_time];
        }
        return $where;
    }


    public function add()
    {
        $param = get_param();
        if (request()->isAjax()) {
            return $this->save($param);
        }
        $item = $this->getFields();
        $item = array_merge($item, $param);
        return $this->form($item);
    }

    public function edit()
    {
        $param = get_param();
        if (request()->isAjax()) {
            return $this->save($param);
        }
        $id = !empty($param['id']) ? $param['id'] : 0;
        $item = Db::table($this->table)->where('id', $id)->find();
        return $this->form($item);
    }

    public function initForm($item)
    {
        $item['id'] = $item['id'] ?? 0;
        return $item;
    }

    public function form($item)
    {
        View::assign('item', $this->initForm($item));
        return view('form');
    }

    public function save($param)
    {
        $param['admin_id'] = get_login_admin('id');
        try {
            if ($this->checkValidate) {
                $this->validate->check($param);
            }
            $param['updated_at'] = Carbon::now()->toDateTimeString();
            if (empty($param['id'])) {
                $param['created_at'] = Carbon::now()->toDateTimeString();
                $id = Db::table($this->table)->strict(false)->field(true)->insertGetId($param);
                add_log('add', $id, $param);
            } else {
                Db::table($this->table)->where(['id' => $param['id']])->strict(false)->field(true)->update($param);
                add_log('edit', $param['id'], $param);
            }
            return $this->success();
        } catch (\Exception $e) {
            return $this->error($e->getMessage());
        }
    }


    public function delete()
    {
        $param = get_param();
        try {
            $item = Db::table($this->table)->find($param['id']);
            Db::table($this->table)->where('id', $param['id'])->delete();
            add_log('delete', $item['id'], $item);
            return $this->success();
        } catch (\Exception $e) {
            return $this->error($e->getMessage());
        }
    }

    public function setTable($table)
    {
        $this->table = $table;
    }

    public function setValidate(Validate $validate, $scene = '')
    {
        $this->checkValidate = true;
        $this->validate = $validate;
        if ($scene != '') {
            $this->validate = $this->validate->scene($scene);
        }
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
