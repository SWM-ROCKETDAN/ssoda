package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.store.Address;
import com.rocketdan.serviceserver.domain.store.Store;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.Column;
import javax.persistence.Embedded;
import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class StoreSaveRequestDto {
    private String name;
    private Integer category;
    private String description;
    private List<MultipartFile> images;
    private MultipartFile logoImage;

    // 주소
    private String city;
    private String country;
    private String town;
    private String roadCode;
    private String road;
    private String zipCode;

    @Builder
    public StoreSaveRequestDto(String name, Integer category, String description, List<MultipartFile> images, MultipartFile logoImage,
                               String city, String country, String town, String roadCode, String road, String zipCode) {
        this.name = name;
        this.category = category;
        this.description = description;
        this.images = images;
        this.logoImage = logoImage;

        this.city = city;
        this.country = country;
        this.town = town;
        this.roadCode = roadCode;
        this.road = road;
        this.zipCode = zipCode;
    }

    public Store toEntity(List<String> imagePaths, String logoImagePath) {
        Address address = addressToEntity();

        return Store.builder()
                .name(name)
                .category(category)
                .address(address)
                .description(description)
                .imagePaths(imagePaths)
                .logoImagePath(logoImagePath)
                .build();
    }

    private Address addressToEntity() {
        return Address.builder()
                .city(city)
                .country(country)
                .town(town)
                .roadCode(roadCode)
                .road(road)
                .zipCode(zipCode)
                .build();
    }
}
