package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventUpdateRequestDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.service.event.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RequiredArgsConstructor
@RestController
public class EventApiController {
    private final EventService eventService;

    /*
    @GetMapping("/events")
    public List<Event> retrieveAllEvents() {
        return eventRepository.findAll();
    }*/

    @GetMapping("/api/v1/events/{id}")
    public EventResponseDto finById(@PathVariable String id) {
        return eventService.findById(id);
    }

    @PostMapping("/api/v1/events/hashtag")
    public String save(@RequestBody HashtagEventSaveRequest requestDto) {
        return eventService.saveHashtagEvent(requestDto);
    }

    @PutMapping("/api/v1/events/hashtag/{id}")
    public String update(@PathVariable String id, @RequestBody HashtagEventUpdateRequest requestDto) {
        return eventService.updateHashtagEvent(id, requestDto);
    }
/*
    @DeleteMapping("/events/{id}")
    public void deleteEvent(@PathVariable String id) {
        eventRepository.deleteById(id);
    }

     */
}
