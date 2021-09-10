package com.rocketdan.serviceserver.app.dto.reward;

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Getter
@NoArgsConstructor
public class RewardUpdateRequestDto {
    private Integer level;
    private Integer category;
    private String name;
    private MultipartFile image;
    private Integer price;
    private Integer count;

    private List<RewardSaveRequestDto> rewards;

    public RewardUpdateRequestDto(Integer level, Integer category, String name, MultipartFile image, Integer price, Integer count) {
        this.level = level;
        this.category = category;
        this.name = name;
        this.image = image;
        this.price = price;
        this.count = count;
    }
}
