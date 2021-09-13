package com.rocketdan.serviceserver.app.dto.reward;

import com.rocketdan.serviceserver.domain.reward.Reward;
import lombok.Getter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
public class RewardUpdateRequestDto {
    private Long id;
    private Integer level;
    private Integer category;
    private String name;
    private MultipartFile image;
    private Integer price;
    private Integer count;

    private List<RewardUpdateRequestDto> rewards;

    public Reward toEntity(String imagePath) {
        return Reward.builder()
                .level(level)
                .category(category)
                .name(name)
                .imagePath(imagePath)
                .price(price)
                .count(count)
                .build();
    }

    public RewardUpdateRequestDto(Long id, Integer level, Integer category, String name, MultipartFile image, Integer price, Integer count) {
        this.id = id;
        this.level = level;
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.count = count;
    }
}
