<?php
declare (strict_types=1);

namespace app\command;

use think\console\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\input\Option;
use think\console\Output;

use Carbon\Carbon;
use think\facade\Db;

class Hello extends Command
{
    protected function configure()
    {
        // 指令配置
        $this->setName('hello')->setDescription('the hello command');
    }

    protected function execute(Input $input, Output $output)
    {
        $list = Db::name('house')->alias('h')->field(['h.*', 'c.min_price', 'c.max_price'])
            ->join('house_cate c', 'h.cate_id = c.id')
            ->where(['h.active' => 1])->select()->toArray();
        foreach ($list as $key => $vo) {
            if ($vo['price'] > $vo['max_price']) {
                // 舍去法取整
                $num = floor($vo['price'] / $vo['min_price']);
                $data = $vo;
                unset($data['id'], $data['admin_id'], $data['updated_at'], $data['min_price'], $data['max_price']);
                $data['pid'] = $vo['id'];
                // 价格一样
                for ($i = 1; $i <= intval($num - 1); $i++) {
                    $data['price'] = $vo['min_price'];
                    $data['created_at'] = Carbon::now()->toDateTimeString();
                    Db::name('house')->insert($data);
                }
                // 价格不一样
                $data['price'] = $vo['price'] - (intval($num - 1) * $vo['min_price']);
                $data['created_at'] = Carbon::now()->toDateTimeString();
                Db::name('house')->insert($data);
                // 将原先的房产设为无效
                Db::name('house')->where(['id' => $vo['id']])->save(['effective' => 0]);
            } else {
                continue;
            }
        }
        // 指令输出
        $output->writeln('操作成功！');
    }
}
