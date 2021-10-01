package com.rocketdan.serviceserver.web.dto.join;

import com.rocketdan.serviceserver.domain.event.RewardPolicy;
import lombok.Getter;

@Getter
public class SaveJoinPostResult {
    private Long joinPostId;
    private RewardPolicy rewardPolicy;

    public SaveJoinPostResult(Long joinPostId, RewardPolicy rewardPolicy) {
        this.joinPostId = joinPostId;
        this.rewardPolicy = rewardPolicy;
    }
}
