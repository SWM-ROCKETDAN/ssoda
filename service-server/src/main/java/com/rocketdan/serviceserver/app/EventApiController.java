package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.service.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class EventApiController {
    private final EventService eventService;

    @GetMapping("/api/v1/events")
    public List<EventListResponseDto> retrieveAllEvents() {
        return eventService.findAll();
    }

//    @GetMapping("/api/v1/events/")
//    public EventListResponseDto retrieveEventList() {
//        return eventService.findListById();
//    }

    @GetMapping("/api/v1/events/{id}")
    public EventResponseDto findById(@PathVariable Long id) {
        return eventService.findById(id);
    }

    @PostMapping("/api/v1/events/hashtag")
    public Long save(@RequestBody HashtagEventSaveRequest event) {
        return eventService.save(event);
    }

    @PutMapping("/api/v1/events/hashtag/{id}")
    public Long update(@PathVariable Long id, @RequestBody HashtagEventUpdateRequest requestDto) {
        return eventService.updateHashtagEvent(id, requestDto);
    }

    @DeleteMapping("/api/v1/events/{id}")
    public void delete(@PathVariable Long id) {
        eventService.delete(id);
    }
}
