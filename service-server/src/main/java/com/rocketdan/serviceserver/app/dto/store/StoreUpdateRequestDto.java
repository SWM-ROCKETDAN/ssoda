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

    private List<MultipartFile> newImages;
    private List<String> deleteImagePaths;

    private MultipartFile logoImage;

    // 주소
    private String city;
    private String country;
    private String town;
    private String road;
    private String zipCode;
    private String buildingCode;
    private Double latitude;
    private Double longitude;


    @Builder
    public StoreUpdateRequestDto(String name, Integer category, String description, List<MultipartFile> newImages, List<String> deleteImagePaths, MultipartFile logoImage,
                                 String city, String country, String town, String road, String zipCode, String buildingCode, Double latitude, Double longitude) {
        this.name = name;
        this.category = category;
        this.description = description;
        this.newImages = newImages;
        this.deleteImagePaths = deleteImagePaths;
        this.logoImage = logoImage;

        this.city = city;
        this.country = country;
        this.town = town;
        this.road = road;
        this.zipCode = zipCode;
        this.buildingCode = buildingCode;
        this.latitude = latitude;
        this.longitude = longitude;
    }

    public Address addressToEntity() {
        return Address.builder()
                .city(city)
                .country(country)
                .town(town)
                .road(road)
                .zipCode(zipCode)
                .buildingCode(buildingCode)
                .latitude(latitude)
                .longitude(longitude)
                .build();
    }
}
