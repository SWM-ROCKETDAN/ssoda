package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.s3.service.ImageManagerService;
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
        List<Long> reward_ids = new ArrayList<>();

        // 리워드 1개씩 저장
        for (RewardSaveRequestDto reward : rewards.getRewards() ){
            reward_ids.add(rewardService.save(event_id, reward, principal));
        }

        return reward_ids;
    }
/*
    @PostMapping("/events/{event_id}")
    public Long save(@PathVariable Long event_id, @ModelAttribute RewardSaveRequestDto reward) {
        String imgPath = imageManagerService.upload("image/reward", reward.getImage());

        return rewardService.save(event_id, reward, imgPath);
    }
*/
}
