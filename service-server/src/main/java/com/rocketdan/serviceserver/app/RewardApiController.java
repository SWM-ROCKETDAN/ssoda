package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.reward.RewardDeleteRequestDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardUpdateRequestDto;
import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.service.RewardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/rewards")
public class RewardApiController {
    private final RewardService rewardService;

    @GetMapping("/{id}")
    public RewardResponseDto retrieveReward(@PathVariable Long id) {
        return rewardService.findById(id);
    }

    @PostMapping("/events/{event_id}")
    public List<Long> saveList(@PathVariable Long event_id, @ModelAttribute RewardSaveRequestDto rewards, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        List<Long> rewardIds = new ArrayList<>();

        // 리워드 1개씩 저장
        for (RewardSaveRequestDto reward : rewards.getRewards() ){
            rewardIds.add(rewardService.save(event_id, reward, principal));
        }

        return rewardIds;
    }

    @PutMapping()
    public List<Long> updateList(@ModelAttribute RewardUpdateRequestDto rewards, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        List<Long> rewardIds = new ArrayList<>();

        // 리워드 1개씩 update
        for (RewardUpdateRequestDto reward : rewards.getRewards() ){
            rewardIds.add(rewardService.update(reward, principal));
        }

        return rewardIds;
    }

    @DeleteMapping()
    public void deleteList(@RequestBody RewardDeleteRequestDto requestDto, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        // 리워드 1개씩 삭제
        for (Long id: requestDto.getRewardIds()) {
            rewardService.softDelete(id, principal);
        }
    }
}
