<?php

declare (strict_types=1);

namespace app\store\controller;

use app\store\BaseController;
use Carbon\Carbon;
use think\facade\App;
use think\facade\Cache;
use think\facade\Db;
use think\facade\Filesystem;
use think\facade\Validate;

class ApiController extends BaseController
{
    //上传文件
    public function upload()
    {
        $param = get_param();
        $sourse = 'file';
        if (isset($param['sourse'])) {
            $sourse = $param['sourse'];
        }
        if ($sourse == 'file' || $sourse == 'tinymce') {
            if (request()->file('file')) {
                $file = request()->file('file');
            } else {
                return $this->error('没有选择上传文件');
            }
        } else {
            if (request()->file('editormd-image-file')) {
                $file = request()->file('editormd-image-file');
            } else {
                return $this->error('没有选择上传文件');
            }
        }
        // 获取上传文件的hash散列值
        $sha1 = $file->hash('sha1');
        $md5 = $file->hash('md5');
        $rule = [
            'image' => 'jpg,png,jpeg,gif',
            'doc' => 'doc,docx,ppt,pptx,xls,xlsx,pdf',
            'file' => 'zip,gz,7z,rar,tar',
            'video' => 'mpg,mp4,mpeg,avi,wmv,mov,flv,m4v',
        ];
        $fileExt = $rule['image'] . ',' . $rule['doc'] . ',' . $rule['file'] . ',' . $rule['video'];
        //1M=1024*1024=1048576字节
        $fileSize = 100 * 1024 * 1024;
        if (isset($param['type']) && $param['type']) {
            $fileExt = $rule[$param['type']];
        }
        if (isset($param['size']) && $param['size']) {
            $fileSize = $param['size'];
        }
        $validate = Validate::rule([
            'image' => 'require|fileSize:' . $fileSize . '|fileExt:' . $fileExt,
        ]);
        $file_check['image'] = $file;
        if (!$validate->check($file_check)) {
            return $this->error($validate->getError());
        }
        // 日期前綴
        $dataPath = date('Ym');
        $use = 'thumb';
        $filename = Filesystem::disk('public')->putFile($dataPath, $file, function () use ($md5) {
            return $md5;
        });
        if ($filename) {
            //写入到附件表
            $data = [];
            $path = get_config('filesystem.disks.public.url');
            $data['filepath'] = $path . '/' . $filename;
            $data['name'] = $file->getOriginalName();
            $data['mimetype'] = $file->getOriginalMime();
            $data['fileext'] = $file->extension();
            $data['filesize'] = $file->getSize();
            $data['filename'] = $filename;
            $data['sha1'] = $sha1;
            $data['md5'] = $md5;
            $data['module'] = App::initialize()->http->getName();
            $data['action'] = app('request')->action();
            $data['uploadip'] = app('request')->ip();
            $data['created_at'] = Carbon::now()->toDateTimeString();
            $data['user_id'] = get_login_admin('id') ? get_login_admin('id') : 0;
            if ($data['module'] = 'admin') {
                //通过后台上传的文件直接审核通过
                $data['status'] = 1;
                $data['admin_id'] = $data['user_id'];
                $data['audit_time'] = time();
            }
            $data['use'] = request()->has('use') ? request()->param('use') : $use; //附件用处
            $res['id'] = Db::name('file')->insertGetId($data);
            $res['filepath'] = $data['filepath'];
            $res['name'] = $data['name'];
            $res['filename'] = $data['filename'];
            add_log('upload', $data['user_id'], $data);
            if ($sourse == 'editormd') {
                //editormd编辑器上传返回
                return json(['success' => 1, 'message' => '上传成功', 'url' => $data['filepath']]);
            } else if ($sourse == 'tinymce') {
                //tinymce编辑器上传返回
                return json(['success' => 1, 'message' => '上传成功', 'location' => $data['filepath']]);
            } else {
                //普通上传返回
                return $this->success('上传成功', $res);
            }
        } else {
            return $this->error('上传失败，请重试');
        }
    }


    //清空缓存
    public function cache_clear()
    {
        Cache::clear();
        return $this->success('系统缓存已清空');
    }


}
