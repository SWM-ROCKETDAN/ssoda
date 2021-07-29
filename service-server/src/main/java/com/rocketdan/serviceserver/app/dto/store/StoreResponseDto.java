package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.store.Address;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.transaction.annotation.Transactional;

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
    private List<String> images;
    private List<Long> event_ids;

    public StoreResponseDto(Store entity) {
        this.id = entity.getId();
        this.name = entity.getName();
        this.category = entity.getCategory();
        this.address = entity.getAddress();
        this.description = entity.getDescription();
        this.images = List.copyOf(entity.getImages());
        this.event_ids = entity.getEvents().stream().map(Event::getId).collect(Collectors.toList());
    }
}
