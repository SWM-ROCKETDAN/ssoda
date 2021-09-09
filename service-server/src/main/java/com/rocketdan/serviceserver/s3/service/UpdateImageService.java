package com.rocketdan.serviceserver.s3.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class UpdateImageService {
    private final ImageManagerService imageManagerService;

    public String uploadNewImage(MultipartFile newImage, String folderName) {
        String imgPath = null;

        // newImage 필드가 존재하고, 데이터가 들어있을 때
        if (Optional.ofNullable(newImage).isPresent()) {
            if (newImage.isEmpty()) {
                imgPath = imageManagerService.upload(folderName, newImage);
            }
        }

        return imgPath;
    }

    public List<String> uploadNewImages(List<MultipartFile> newImages, String folderName) {
        List<String> imgPaths = new ArrayList<>();

        // newImages 필드가 존재하고, 데이터가 들어있을 때
        if (Optional.ofNullable(newImages).isPresent()) {
            if (newImages.get(0).getSize() != 0) {
                imgPaths = imageManagerService.upload(folderName, newImages);
            }
        }

        return imgPaths;
    }

    public void deleteImagePath(String deleteImagePath) {
        // deleteImagePath 필드가 존재하고, 데이터가 들어있을 때
        if (Optional.ofNullable(deleteImagePath).isPresent()) {
            if (!deleteImagePath.isEmpty()) {
                imageManagerService.delete(deleteImagePath);
            }
        }
    }

    public List<String> deleteImagePaths(List<String> prevImgPaths, List<String> deleteImagePaths) {
        // deleteImagePaths 필드가 존재하고, 데이터가 들어있을 때
        if (Optional.ofNullable(deleteImagePaths).isPresent()) {
            if (!deleteImagePaths.isEmpty()) {
                imageManagerService.delete(deleteImagePaths);
            }

            if (!prevImgPaths.isEmpty()) {
                deleteImagePaths.forEach(prevImgPaths::remove);
            }
        }
        return prevImgPaths;
    }
}
