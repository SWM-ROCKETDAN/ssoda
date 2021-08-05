package com.rocketdan.serviceserver.app.dto.reward;

import com.rocketdan.serviceserver.domain.event.reward.Reward;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Setter
@Getter
@NoArgsConstructor
public class RewardSaveRequestDto {
    private Integer level;
    private Integer category;
    private String name;
    private MultipartFile image;
    private Integer price;
    private Integer count;

    private List<RewardSaveRequestDto> rewards;

    public Reward toEntity(String image) {
        return Reward.builder()
                .level(level)
                .category(category)
                .name(name)
                .image(image)
                .price(price)
                .count(count)
                .usedCount(0)
                .build();
    }
}
