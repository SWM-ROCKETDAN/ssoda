package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Getter;

import java.util.List;

@Getter
public class StoreListResponseDto {
    private Long id;
    private String name;
    private List<String> imagePaths;

    public StoreListResponseDto(Store entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.imagePaths = List.copyOf(entity.getImagePaths());
    }
}
