package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.app.dto.reward.RewardSaveRequestDto;
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
    private final ImageManagerService imageManagerService;

    @GetMapping("/{id}")
    public RewardResponseDto retrieveReward(@PathVariable Long id) {
        return rewardService.findById(id);
    }

    @PostMapping("/events/{event_id}")
    public List<Long> save(@PathVariable Long event_id, @ModelAttribute List<RewardSaveRequestDto> rewards) {
        List<Long> reward_ids = new ArrayList<>();

        // 리워드 1개씩 저장
        for (RewardSaveRequestDto reward : rewards ){
            String imgPath = imageManagerService.upload("image/reward", reward.getImage());
            reward_ids.add(rewardService.save(event_id, reward, imgPath));
        }

        return reward_ids;
    }

}
