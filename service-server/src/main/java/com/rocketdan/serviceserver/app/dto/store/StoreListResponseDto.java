package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Getter;

import java.util.List;

@Getter
public class StoreListResponseDto {
    private Long id;
    private String name;
    private Integer category;
    private List<String> images;

    public StoreListResponseDto(Store entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.category = entity.getCategory();
        this.images = List.copyOf(entity.getImages());
    }
}
