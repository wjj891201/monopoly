<?php


namespace app\admin\validate;

use think\Validate;
use think\facade\Db;

class ArticleCateValidate extends Validate
{
    // 自定義驗證規則
    protected function checkOne($value, $rule, $data = [])
    {
        $count = Db::name('article_cate')->where([['title', '=', $data['title']], ['id', '<>', $data['id']]])->count();
        return $count == 0;
    }

    protected $rule = [
        'title' => 'require|checkOne',
    ];

    protected $message = [
        'title.require' => '分類名稱不能為空',
        'title.checkOne' => '同樣的分類名稱已經存在',
    ];
}
