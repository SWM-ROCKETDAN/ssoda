package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.TestDto;
import com.rocketdan.serviceserver.s3.service.ImageManagerService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@RestController
@RequiredArgsConstructor
public class ImageTestController {
    private final ImageManagerService imageManagerService;

    @PostMapping("/test")
    public void imgTest(@ModelAttribute TestDto testDto) {
        List<String> imgPaths = imageManagerService.uploadTest("image/event", testDto.getFiles());
        System.out.println(imgPaths);
    }
}
