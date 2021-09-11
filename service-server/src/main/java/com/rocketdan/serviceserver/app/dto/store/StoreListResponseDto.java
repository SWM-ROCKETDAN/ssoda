package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Getter;

@Getter
public class StoreListResponseDto {
    private Long id;
    private String name;
    private String logoImagePath;

    public StoreListResponseDto(Store entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.logoImagePath = entity.getLogoImagePath();
    }
}
