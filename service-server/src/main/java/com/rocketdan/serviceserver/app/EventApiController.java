package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.event.EventUpdateRequestDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.domain.event.Event;
import com.rocketdan.serviceserver.service.event.EventService;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.beans.factory.annotation.Autowired;
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
    public EventResponseDto findById(@PathVariable ObjectId id) {
        return eventService.findById(id);
    }

    @PostMapping("/api/v1/events/hashtag")
    public ObjectId save(@RequestBody HashtagEventSaveRequest requestDto) {
        return eventService.saveHashtagEvent(requestDto);
    }

    @PutMapping("/api/v1/events/hashtag/{id}")
    public ObjectId update(@PathVariable ObjectId id, @RequestBody EventUpdateRequestDto requestDto) {
        return eventService.update(id, requestDto);
    }
/*
    @DeleteMapping("/events/{id}")
    public void deleteEvent(@PathVariable ObjectId id) {
        eventRepository.deleteById(id);
    }

     */
}
