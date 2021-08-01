package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.service.EventService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/events")
public class EventApiController {
    private final EventService eventService;

    @GetMapping
    public List<EventListResponseDto> retrieveAllEvents() {
        return eventService.findAll();
    }

    @GetMapping("/{id}")
    public EventResponseDto findById(@PathVariable Long id) {
        return eventService.findById(id);
    }

    @PostMapping("/hashtag/stores/{store_id}")
    public Long saveHashtagEvent(@PathVariable Long store_id, @RequestBody HashtagEventSaveRequest event) {
        return eventService.saveHashtagEvent(store_id, event);
    }

    @PutMapping("/hashtag/{id}")
    public Long update(@PathVariable Long id, @RequestBody HashtagEventUpdateRequest requestDto) {
        return eventService.updateHashtagEvent(id, requestDto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        eventService.delete(id);
    }
}
