package com.rocketdan.serviceserver.web;

import com.rocketdan.serviceserver.domain.event.RewardPolicy;

public class SaveJoinPostResult {
    Long joinPostId;
    RewardPolicy rewardPolicy;

    public SaveJoinPostResult(Long joinPostId, RewardPolicy rewardPolicy) {
        this.joinPostId = joinPostId;
        this.rewardPolicy = rewardPolicy;
    }
}
