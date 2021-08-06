package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.store.Address;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class StoreSaveRequestDto {
    private String name;
    private Integer category;
    private Address address;
    private String description;
    private List<MultipartFile> images;

    @Builder
    public StoreSaveRequestDto(String name, Integer category, Address address, String description, List<MultipartFile> images) {
        this.name = name;
        this.category = category;
        this.address = address;
        this.description = description;
        this.images = images;
    }

    public Store toEntity(List<String> images) {
        return Store.builder()
                .name(name)
                .category(category)
                .address(address)
                .description(description)
                .images(images)
                .build();
    }
}
