package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.store.Address;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@NoArgsConstructor
public class StoreResponseDto {
    private Long id;
    private String name;
    private Integer category;
    private Address address;
    private String description;
    private List<String> imagePaths;
    private String logoImagePath;
    private List<Long> eventIds;

    public StoreResponseDto(Store entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.category = entity.getCategory();
        this.address = entity.getAddress();
        this.description = entity.getDescription();
        this.imagePaths = List.copyOf(entity.getImagePaths());
        this.logoImagePath = entity.getLogoImagePath();
        this.eventIds = entity.getEvents().stream().map(Event::getId).collect(Collectors.toList());
    }
}
