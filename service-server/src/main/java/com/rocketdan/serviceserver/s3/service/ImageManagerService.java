package com.rocketdan.serviceserver.s3.service;

import com.rocketdan.serviceserver.Exception.file.FileConvertException;
import com.rocketdan.serviceserver.Exception.file.FileUploadException;
import com.rocketdan.serviceserver.manager.FileManager;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ImageManagerService {

    private final FileManager fileManager;
    private final S3Service s3Service;

    private static final String formDataFileKey = "image";

    // 임시 파일 생성 & 업데이트 & 임시 파일 삭제
    public String createAndUploadFile(MultipartFile mf, String filePath) {
        long time = System.currentTimeMillis();
        String originalFilename = mf.getOriginalFilename();
        // 파일명 = 원본 파일명 + currentTimeMillis()에서 가져온 시간
        String saveFileName = String.format("%d_%s", time, originalFilename.replaceAll(" ", ""));

        // 파일 생성
        File uploadFile = null;
        try {
            Optional<File> uploadFileOpt = fileManager.convertMultipartFileToFile(mf);
            if(uploadFileOpt.isEmpty()) {
                throw new FileConvertException();
            }
            uploadFile = uploadFileOpt.get();

            // 파일 업로드
            String saveFilePath = s3Service.upload(uploadFile, filePath, saveFileName);

            // 파일명과 저장경로를 객체에 저장해 리턴
            return File.separator + saveFilePath;
        } catch (IOException e) {
            e.printStackTrace();
            throw new FileUploadException();
        } finally {
            // 파일 삭제
            if(uploadFile != null){
                uploadFile.delete();
            }
        }
    }


    /**
     * 이미지 업로드
     */
    public List<String> upload(String folderName, MultipartHttpServletRequest request) {
        List<MultipartFile> images = request.getFiles(formDataFileKey);

        String foldDiv = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMM"));
        String filePath = folderName + File.separator + foldDiv;


        List<String> fileNames = new ArrayList<>();

        for (MultipartFile mf : images) {
            // 파일 업로드 호출
            fileNames.add(createAndUploadFile(mf, filePath));
        }

        return fileNames;
    }
}
