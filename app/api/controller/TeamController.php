<?php

namespace app\api\controller;

use Carbon\Carbon;
use app\service\TeamService;
use app\service\RewardService;
use app\api\controller\CommonController;

class TeamController extends CommonController
{

    private TeamService $teamService;
    private RewardService $rewardService;

    public function initialize()
    {
        parent::initialize();
        $this->teamService = new TeamService();
        $this->rewardService = new RewardService();
    }

    public function total()
    {
        try {
            //直推人數
            $directList = $this->teamService->getDirectList(JWT_UID);
            $resp['direct_list'] = $directList;
            $resp['direct_total'] = count($directList);

            //團隊人數
            $allMember = $this->teamService->getAllMember();
            $childList = $this->teamService->getChildList(JWT_UID, $allMember);
            $resp['team_total'] = count($childList);

            //當日收益
            $rewardToday = $this->rewardService->sumReward([
                'member_id' => JWT_UID,
                'start_at' => Carbon::now()->startOfDay()->toDateTimeString(),
                'end_at' => Carbon::now()->endOfDay()->toDateTimeString(),
            ]);
            $resp['reward_today'] = round($rewardToday, 2);

            //累計收益
            $rewardTotal = $this->rewardService->sumReward([
                'member_id' => JWT_UID,
            ]);
            $resp['reward_total'] = round($rewardTotal, 2);

            return $this->apiData($resp);
        } catch (\Exception $e) {
            return $this->apiError($e->getMessage());
        }
    }
}
