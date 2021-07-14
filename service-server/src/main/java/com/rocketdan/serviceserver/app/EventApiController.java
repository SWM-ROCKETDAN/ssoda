package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.domain.event.EventRepository;
import com.rocketdan.serviceserver.service.event.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
public class EventApiController {
    private final EventService eventService;
/*
    @GetMapping("/api/v1/events")
    public List<EventListResponseDto> retrieveAllEvents() {
        return eventService.findAll();
    }
//    @GetMapping("/api/v1/events/")
//    public EventListResponseDto retrieveEventList() {
//        return eventService.findListById();
//    }

    @GetMapping("/api/v1/events/{id}")
    public EventResponseDto findById(@PathVariable String id) {
        return eventService.findById(id);
    }*/

    @PostMapping("/api/v1/events/hashtag")
    public Long save(@RequestBody HashtagEventSaveRequest event) {
        return eventService.save(event);
    }

    @PutMapping("/api/v1/events/hashtag/{id}")
    public Long update(@PathVariable Long id, @RequestBody HashtagEventUpdateRequest requestDto) {
        return eventService.updateHashtagEvent(id, requestDto);
    }
/*
    @DeleteMapping("/api/v1/events/{id}")
    public void deleteEvent(@PathVariable String id) {
        eventService.delete(id);
    }*/
}
