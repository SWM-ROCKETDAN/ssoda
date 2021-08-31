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
    private MultipartFile logoImage;

    @Builder
    public StoreSaveRequestDto(String name, Integer category, Address address, String description, List<MultipartFile> images, MultipartFile logoImage) {
        this.name = name;
        this.category = category;
        this.address = address;
        this.description = description;
        this.images = images;
        this.logoImage = logoImage;
    }

    public Store toEntity(List<String> imagePaths, String logoImagePath) {
        return Store.builder()
                .name(name)
                .category(category)
                .address(address)
                .description(description)
                .imagePaths(imagePaths)
                .logoImagePath(logoImagePath)
                .build();
    }
}
