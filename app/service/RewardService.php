<?php

namespace app\service;

use app\model\AccountRewardModel;
use think\facade\Log;

class RewardService
{
    public AccountRewardModel $rewardModel;
    public TeamService $teamService;
    private AccountService $accountService;


    private static $instance = null;

    public static function getInstance()
    {
        if (is_null(self::$instance)) {
            self::$instance = new RewardService();
        }
        return self::$instance;
    }


    public function __construct()
    {
        $this->rewardModel = new AccountRewardModel();
        $this->teamService = new TeamService();
        $this->accountService = new AccountService();
    }

    public function sumReward($param = [])
    {
        $where = [];

        if (!empty($param['member_id'])) {
            $where[] = ['member_id', '=', $param['member_id']];
        }

        if (!empty($param['start_at'])) {
            $where[] = ['created_at', '>=', $param['start_at']];
        }

        if (!empty($param['end_at'])) {
            $where[] = ['created_at', '<=', $param['end_at']];
        }

        if (!empty($param['item'])) {
            $where[] = ['item', '=', $param['item']];
        }

        return $this->rewardModel->sumReward($where);
    }


    public function spotFeeParentList($amount, $member, $parentList, $itemID = 0)
    {
        if ($amount <= 0) {
            return;
        }
        $alreadyReward = 0;
        foreach ($parentList as $key => $parent) {
            if (!$parent['role_id']) continue;
            $parentRole = $this->teamService->getRole($parent['role_id']);

            //1、直推
            if ($key == 0) {
                $rewardAmount = round($amount * $parentRole['reward_fee'], 4);
                //如果大于总手续费就断掉
                $alreadyReward += $rewardAmount;
                if ($alreadyReward > $amount) break;
                $this->reward($parent['id'], $member['id'], $rewardAmount, 'spot_fee', $itemID);
            }


            //2、无限上级
            if ($key > 0) {
                //如果上级小于等于下级就断掉，不再往上找上级
                if ($parent['role_id'] <= $parentList[$key - 1]['role_id']) {
                    break;
                }
                $childRole = $this->teamService->getRole($parentList[$key - 1]['role_id']);
                $subReward = $parentRole['reward_fee'] - $childRole['reward_fee'];
                if ($subReward <= 0) continue;
                $rewardAmount = round($amount * $subReward, 4);
                //如果大于总手续费就断掉
                $alreadyReward += $rewardAmount;
                if ($alreadyReward > $amount) break;
                $this->reward($parent['id'], $member['id'], $rewardAmount, 'spot_fee', $itemID);
            }
        }
    }


    public function swapFeeParentList($amount, $member, $parentList, $itemID = 0)
    {
        if ($amount <= 0) {
            return;
        }
        $alreadyReward = 0;
        foreach ($parentList as $key => $parent) {
            if (!$parent['role_id']) continue;
            $parentRole = $this->teamService->getRole($parent['role_id']);

            //1、直推
            if ($key == 0) {
                $rewardAmount = round($amount * $parentRole['reward_fee'], 4);
                //如果大于总手续费就断掉
                $alreadyReward += $rewardAmount;
                if ($alreadyReward > $amount) break;
                $this->reward($parent['id'], $member['id'], $rewardAmount, 'swap_fee', $itemID);
            }


            //2、无限上级
            if ($key > 0) {
                //如果上级小于等于下级就断掉，不再往上找上级
                if ($parent['role_id'] <= $parentList[$key - 1]['role_id']) {
                    break;
                }
                $childRole = $this->teamService->getRole($parentList[$key - 1]['role_id']);
                $subReward = $parentRole['reward_fee'] - $childRole['reward_fee'];
                if ($subReward <= 0) continue;
                $rewardAmount = round($amount * $subReward, 4);
                //如果大于总手续费就断掉
                $alreadyReward += $rewardAmount;
                if ($alreadyReward > $amount) break;
                $this->reward($parent['id'], $member['id'], $rewardAmount, 'swap_fee', $itemID);
            }
        }
    }


    public function reward($to, $from, $amount, $scene, $itemID)
    {
        $currentID = 2;
        $currentCode = 'USDT';
        try {
            $data = [
                'member_id' => $to,
                'item' => $scene,
                'item_id' => $itemID,
                'from_member_id' => $from,
                'amount' => $amount,
                'currency_id' => $currentID,
                'currency_code' => $currentCode,
                'is_settled' => 1,
                'asset_type' => 'funding',
            ];
            $id = $this->rewardModel->addReward($data);

            //增加用户余额
            $this->accountService->updateAccount([
                'member_id' => $to,
                'scene' => 'reward',
                'asset_type' => 'funding',
                'balance_type' => 'available',
                'operate_type' => 'add',
                'currency_id' => $currentID,
                'amount' => $amount,
                'item_id' => $id,
            ]);
        } catch (\Exception $e) {

            Log::error($to . '~' . $e->getMessage());
        }
    }
}
