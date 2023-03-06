<?php


namespace app\admin\validate;

use think\Validate;

class BannerValidate extends Validate
{
    protected $rule = [
        'title' => 'require|unique:banner',
        'id' => 'require',
        'status' => 'require',
        'img' => 'require',
        'cate_id' => 'require',
    ];

    protected $message = [
        'title.require' => '標題不能為空',
        'title.unique' => '同樣的標題已經存在',
        'id.require' => '缺少更新條件',
        'status.require' => '狀態為必選',
        'img.require' => '請上傳圖片',
        'cate_id.require' => '廣告位不能為空',
    ];

    protected $scene = [
        'add' => ['title', 'status'],
        'edit' => ['id', 'title', 'status'],
        'addInfo' => ['title', 'img', 'status', 'cate_id'],
        'editInfo' => ['title', 'img', 'status', 'id'],
    ];
}
