package com.rocketdan.serviceserver.app.dto.report.event;

import com.rocketdan.serviceserver.domain.reward.Reward;

public class RewardInReportOfEvent {
    private Integer level;
    private String name;
    private Integer price;
    private Integer count;

    public RewardInReportOfEvent(Reward reward) {
        this.level = reward.getLevel();
        this.name = reward.getName();
        this.price = reward.getPrice();
        this.count = reward.getCount();
    }
}
