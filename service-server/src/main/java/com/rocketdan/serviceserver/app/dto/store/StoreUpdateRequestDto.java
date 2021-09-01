package com.rocketdan.serviceserver.app.dto.store;

import com.rocketdan.serviceserver.domain.store.Address;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@NoArgsConstructor
@Getter
@Setter
public class StoreUpdateRequestDto {
    private String name;
    private Integer category;
    private String description;

    private List<MultipartFile> images;
    private List<MultipartFile> newImages;
    private List<String> deleteImagePaths;

    private MultipartFile logoImage;

    // 주소
    private String city;
    private String country;
    private String town;
    private String roadCode;
    private String road;
    private String zipCode;

    @Builder
    public StoreUpdateRequestDto(String name, Integer category, String description, List<MultipartFile> images, List<MultipartFile> newImages, List<String> deleteImagePaths, MultipartFile logoImage,
                                 String city, String country, String town, String roadCode, String road, String zipCode) {
        this.name = name;
        this.category = category;
        this.description = description;
        this.images = images;
        this.newImages = newImages;
        this.deleteImagePaths = deleteImagePaths;
        this.logoImage = logoImage;
        this.city = city;
        this.country = country;
        this.town = town;
        this.roadCode = roadCode;
        this.road = road;
        this.zipCode = zipCode;
    }

    public Address addressToEntity() {
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
