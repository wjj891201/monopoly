<?php

namespace app\task\controller;

use app\exception\RespException;
use app\service\RewardService;
use app\service\TaskService;
use app\service\TeamService;
use app\task\BaseController;
use Carbon\Carbon;
use think\facade\Config;
use think\facade\Db;
use function GuzzleHttp\Promise\task;

class RewardController extends BaseController
{

    private TaskService $taskService;
    private TeamService $teamService;
    private RewardService $rewardService;

    protected function initialize()
    {
        parent::initialize();
        $this->taskService = new TaskService();
        $this->teamService = new TeamService();
        $this->rewardService = new RewardService();
    }

    public function demo()
    {
        $parent = $this->teamService->getParentList(12);
        return json($parent);
    }


    /**
     * 现货
     * @return \think\response\Json
     */
    public function spotFee()
    {

        try {
            $check = $this->taskService->checkTask('reward_spot_fee');
            if ($check !== true) {
                throw new RespException(1, '今天已處理');
            }

            //統計前一天已經結算未獎勵的的訂單數據
            $startTime = Carbon::yesterday()->startOfDay()->toDateTimeString();
            $endTime = Carbon::yesterday()->endOfDay()->toDateTimeString();
            $orderList = Db::name('spot_order')->where([
                ['finished_at', '>=', $startTime],
                ['finished_at', '<=', $endTime],
                ['status', '=', 'finish'],
                ['third_order_status', '=', 2],
                ['is_reward', '=', 0],
            ])->select()->toArray();


            $count = 0;
            foreach ($orderList as $key => $value) {
                //不管有没有处理完，都要强制已经返佣
                Db::name('spot_order')->where('id', $value['id'])->update([
                    'is_settled' => 1,
                    'is_reward' => 1
                ]);

                $member = $this->teamService->getMember($value['member_id']);
                if (empty($member)) {
                    continue;
                }

                $parentList = $this->teamService->getParentList($member['id']);
                if (count($parentList) == 0) {
                    continue;
                }
                $this->rewardService->spotFeeParentList($value['fee'], $member, $parentList, $value['id']);
                $count += 1;
            }
            $data['startTime'] = $startTime;
            $data['endTime'] = $endTime;
            $data['total'] = $count;
            $this->taskService->finishTaskByKey('reward_spot_fee', $data);
            return $this->apiSuccess('處理完成', $data);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }

    /**
     * 合约
     * @return \think\response\Json
     */
    public function swapFee()
    {
        try {
            $check = $this->taskService->checkTask('reward_swap_fee');
            if ($check !== true) {
                throw new RespException(1, '今天已處理');
            }

            //統計前一天已經結算未獎勵的的訂單數據
            $startTime = Carbon::yesterday()->startOfDay()->toDateTimeString();
            $endTime = Carbon::yesterday()->endOfDay()->toDateTimeString();
            $orderList = Db::name('swap_order')->where([
                ['finished_at', '>=', $startTime],
                ['finished_at', '<=', $endTime],
                ['status', '=', 'finish'],
                ['third_order_status', '=', 2],
                ['is_reward', '=', 0],
            ])->select()->toArray();

            $count = 0;
            foreach ($orderList as $key => $value) {
                Db::name('swap_order')->where('id', $value['id'])->update([
                    'is_settled' => 1,
                    'is_reward' => 1
                ]);

                $member = $this->teamService->getMember($value['member_id']);
                if (empty($member) || $member['pid'] == 0) {
                    continue;
                }

                $parentList = $this->teamService->getParentList($member['id']);
                if (count($parentList) == 0) {
                    continue;
                }
                $fee = $value['open_fee'] + $value['close_fee'];
                $this->rewardService->swapFeeParentList($fee, $member, $parentList, $value['id']);
                $count += 1;
            }


            $data['startTime'] = $startTime;
            $data['endTime'] = $endTime;
            $data['total'] = $count;
            $this->taskService->finishTaskByKey('reward_swap_fee', $data);
            return $this->apiSuccess('處理完成', $data);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}