<?php


declare (strict_types = 1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\ConfValidate;
use Carbon\Carbon;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\View;

class ConfController extends BaseController
{
    public function index()
    {
        if (request()->isAjax()) {
            $param = get_param();
            $where = array();
            $where[] = ['status', '>=', 0];
            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $content = Db::name('Config')
                ->where($where)
                ->paginate($rows, false);
            return $this->apiTable($content);
        } else {
            return view();
        }
    }

    //添加/編輯配置項
    public function add()
    {
        $param = get_param();
        if (request()->isAjax()) {
            try {
                validate(ConfValidate::class)->check($param);
            } catch (ValidateException $e) {
                // 驗證失敗 輸出錯誤資訊
                return $this->error($e->getError());
            }
            if (!empty($param['id']) && $param['id'] > 0) {
                $param['updated_at'] = Carbon::now()->toDateTimeString();
                $res = Db::name('config')->strict(false)->field(true)->update($param);
                if ($res) {
                    add_log('edit', $param['id'], $param);
                }
                return $this->success();
            } else {
                $param['created_at'] = Carbon::now()->toDateTimeString();
                $insertId = Db::name('config')->strict(false)->field(true)->insertGetId($param);
                if ($insertId) {
                    add_log('add', $insertId, $param);
                }
                return $this->success();
            }
        } else {
            $id = $param['id'] ?? 0;
            if ($id > 0) {
                $config = Db::name('config')->where(['id' => $id])->find();
                View::assign('config', $config);
            }
            View::assign('id', $id);
            return view();
        }
    }

    //刪除配置項
    public function delete()
    {
        $id = get_param('id');
        $data['status'] = '-1';
        $data['id'] = $id;
        $data['updated_at'] = Carbon::now()->toDateTimeString();
        if (Db::name('config')->update($data) !== false) {
            add_log('delete', $id, $data);
            return $this->success('刪除成功');
        } else {
            return $this->error('刪除失敗');
        }
    }

    //編輯配置資訊
    public function edit()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $data['content'] = serialize($param);
            $data['updated_at'] =  Carbon::now()->toDateTimeString();
            $data['id'] = $param['id'];
            $res = Db::name('config')->strict(false)->field(true)->update($data);
            $conf = Db::name('config')->where('id', $param['id'])->find();
            clear_cache('system_config' . $conf['name']);
            if ($res) {
                add_log('edit', $param['id'], $param);
            }
            return $this->success();
        } else {
            $id = $param['id'] ?? 0;
            $conf = Db::name('config')->where('id', $id)->find();
            $module = strtolower(app('http')->getName());
            $class = strtolower(app('request')->controller());
            $action = strtolower(app('request')->action());
            $template = $module . '/view/'. $class .'/'.$conf['name'].'.html';
            $config = [];
            if ($conf['content']) {
                $config = unserialize($conf['content']);
            }
            View::assign('id', $id);
            View::assign('config', $config);
            return view($conf['name']);

        }
    }
}
