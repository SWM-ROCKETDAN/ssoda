package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.domain.event.reward.Reward;
import com.rocketdan.serviceserver.s3.service.ImageManagerService;
import com.rocketdan.serviceserver.service.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
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

    @GetMapping("/{id}/rewards")
    public List<RewardResponseDto> retrieveEventListById(@PathVariable Long id) {
        return eventService.getRewardListById(id);
    }

    @GetMapping("/{id}")
    public EventResponseDto findById(@PathVariable Long id) {
        return eventService.findById(id);
    }

    @PostMapping("/hashtag/stores/{store_id}")
    public Long saveHashtagEvent(@PathVariable Long store_id, @ModelAttribute HashtagEventSaveRequest event) {
        List<String> imgPaths = imageManagerService.upload("image/event", event.getImages());
        return eventService.saveHashtagEvent(store_id, event, imgPaths);
    }

    @PutMapping("/hashtag/{id}")
    public Long updateHashtagEvent(@PathVariable Long id, @ModelAttribute HashtagEventUpdateRequest requestDto) {
        List<String> imgPaths = imageManagerService.upload("image/event", requestDto.getImages());

        return eventService.updateHashtagEvent(id, requestDto, imgPaths);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        eventService.delete(id);
    }
}
