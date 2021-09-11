package com.rocketdan.serviceserver.app.dto.reward;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class RewardDeleteRequestDto {
    List<Long> idList;

    public RewardDeleteRequestDto(List<Long> idList) {
        this.idList = idList;
    }
}
