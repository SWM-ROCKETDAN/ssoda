package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.TestDto;
import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.s3.dto.UploadFileDto;
import com.rocketdan.serviceserver.s3.service.ImageManagerService;
import com.rocketdan.serviceserver.service.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/events")
public class EventApiController {
    private final EventService eventService;

    private final ImageManagerService imageManagerService;

    @GetMapping
    public List<EventListResponseDto> retrieveAllEvents() {
        return eventService.findAll();
    }

    @GetMapping("/{id}")
    public EventResponseDto findById(@PathVariable Long id) {
        return eventService.findById(id);
    }

    @PostMapping("/hashtag/stores/{store_id}")
    public Long saveHashtagEvent(@PathVariable Long store_id, @RequestPart("request") HashtagEventSaveRequest event, @RequestPart("files") MultipartHttpServletRequest files) {
        List<String> imgPaths = imageManagerService.upload("image/event", files);
        return eventService.saveHashtagEvent(store_id, event, imgPaths);
    }

    @PostMapping("/test")
    public void imgTest(@RequestBody TestDto testDto) {
        List<String> imgPaths = imageManagerService.uploadTest("image/event", testDto.getFiles());
    }

    @PutMapping("/hashtag/{id}")
    public Long updateHashtagEvent(@PathVariable Long id, @RequestBody HashtagEventUpdateRequest requestDto) {
        return eventService.updateHashtagEvent(id, requestDto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        eventService.delete(id);
    }
}
