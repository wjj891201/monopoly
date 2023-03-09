<?php


declare (strict_types=1);

namespace app\admin\controller;

use app\admin\BaseController;
use app\admin\validate\BannerValidate;
use app\model\BannerCateModel;
use app\model\BannerModel;
use Carbon\Carbon;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\View;

class BannerController extends BaseController
{
    public function cate_list()
    {
        if (request()->isAjax()) {
            $param = get_param();

            $where = search_where($param,[
                ['id|name|title|desc', 'like', 'keywords'],
            ]);

            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $slide = BannerCateModel::where($where)
                ->order('created_at asc')
                ->paginate($rows, false, ['query' => $param]);
            return $this->apiTable($slide);
        } else {
            return view();
        }
    }

    //添加
    public function cate_add()
    {
        $param = get_param();
        if (request()->isAjax()) {
            if (!empty($param['id']) && $param['id'] > 0) {
                try {
                    validate(BannerValidate::class)->scene('edit')->check($param);
                } catch (ValidateException $e) {
                    // 验证失败 输出错误信息
                    return $this->error($e->getError());
                }
                $param['updated_at'] = Carbon::now()->toDateString();
                $res = BannerCateModel::where('id', $param['id'])->strict(false)->field(true)->update($param);
                if ($res) {
                    add_log('edit', $param['id'], $param);
                }

                clear_cache('banner');
                return $this->success();
            } else {
                try {
                    validate(BannerValidate::class)->scene('add')->check($param);
                } catch (ValidateException $e) {
                    // 验证失败 输出错误信息
                    return $this->error($e->getError());
                }
                $param['created_at'] = Carbon::now()->toDateString();
                $sid = BannerCateModel::strict(false)->field(true)->insertGetId($param);
                if ($sid) {
                    add_log('add', $sid, $param);
                }

                // 删除banner缓存
                clear_cache('banner');
                return $this->success();
            }
        } else {
            $id = $param['id'] ?? 0;
            if ($id > 0) {
                $banner_cate = Db::name('banner_cate')->where(['id' => $id])->find();
                View::assign('banner_cate', $banner_cate);
            }
            View::assign('id', $id);
            return view();
        }
    }

    //删除
    public function cate_delete()
    {
        $id = get_param('id');
        $count = Db::name('banner')->where([
            'cate_id' => $id,
        ])->count();
        if ($count > 0) {
            return $this->error('该组下还有Banner，无法删除');
        }
        if (Db::name('banner')->delete($id) !== false) {
            add_log('delete', $id);
            clear_cache('banner');
            return $this->success('删除成功');
        } else {
            return $this->error('删除失败');
        }
    }

    //管理幻灯片
    public function info()
    {
        $param = get_param();
        if (request()->isAjax()) {
            $where = array();
            $where[] = ['s.cate_id', '=', $param['id']];
            $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
            $slideInfoList = BannerModel::where($where)
                ->alias('s')
                ->join('file f', 's.img=f.id', 'LEFT')
                ->field('s.*,f.filepath')
                ->order('s.sort desc, s.id desc')
                ->paginate($rows, false, ['query' => $param]);
            return $this->apiTable($slideInfoList);
        } else {
            return view('', [
                'cate_id' => $param['id'],
            ]);
        }
    }

    //幻灯片列表
    public function list()
    {
        $param = get_param();
        $where = array();
        $where[] = ['s.cate_id', '=', $param['id']];
        $rows = empty($param['limit']) ? get_config('app.page_size') : $param['limit'];
        $slideInfoList = BannerModel::where($where)
            ->alias('s')
            ->join('file f', 's.img=f.id', 'LEFT')
            ->field('s.*,f.filepath')
            ->order('s.sort desc, s.id desc')
            ->paginate($rows, false, ['query' => $param]);
        return $this->apiTable($slideInfoList);
    }

    //添加幻灯片
    public function add()
    {
        $param = get_param();
        if (request()->isAjax()) {
            if (!empty($param['id']) && $param['id'] > 0) {
                try {
                    validate(BannerValidate::class)->scene('editInfo')->check($param);
                } catch (ValidateException $e) {
                    // 验证失败 输出错误信息
                    return $this->error($e->getError());
                }
                $param['updated_at'] = Carbon::now()->toDateString();
                $res = BannerModel::where(['id' => $param['id']])->strict(false)->field(true)->update($param);
                if ($res) {
                    add_log('edit', $param['id'], $param);
                }

                // 删除缓存
                clear_cache('banner');
                return $this->success();
            } else {
                try {
                    validate(BannerValidate::class)->scene('addInfo')->check($param);
                } catch (ValidateException $e) {
                    // 验证失败 输出错误信息
                    return $this->error($e->getError());
                }
                $param['created_at'] = Carbon::now()->toDateString();
                $sid = BannerModel::strict(false)->field(true)->insertGetId($param);
                if ($sid) {
                    add_log('add', $sid, $param);
                }

                // 删除缓存
                clear_cache('banner');
                return $this->success();
            }
        } else {
            $banner = array();
            $id = isset($param['id']) ? $param['id'] : 0;
            $cate_id = isset($param['sid']) ? $param['sid'] : 0;
            if ($id > 0) {
                $banner = Db::name('banner')->where(['id' => $id])->find();
                $cate_id = $banner['cate_id'];
            }
            View::assign('banner', $banner);
            View::assign('id', $id);
            View::assign('cate_id', $cate_id);
            return view();
        }
    }

    //删除幻灯片
    public function delete()
    {
        $id = get_param('id');
        $item = Db::name('banner')->find($id);
        if (Db::name('banner')->delete($id) !== false) {
            add_log('delete', $id, $item);
            clear_cache('banner');
            return $this->success('删除成功');
        } else {
            return $this->error('删除失败');
        }
    }
}
