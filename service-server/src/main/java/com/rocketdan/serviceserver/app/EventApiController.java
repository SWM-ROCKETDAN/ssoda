package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.EventResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventUpdateRequest;
import com.rocketdan.serviceserver.app.dto.reward.RewardResponseDto;
import com.rocketdan.serviceserver.core.auth.LoginUser;
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

    @GetMapping("/{id}/rewards")
    public List<RewardResponseDto> retrieveRewardListById(@PathVariable Long id) {
        return eventService.getRewardListById(id);
    }

    @GetMapping("/{id}")
    public EventResponseDto findById(@PathVariable Long id) {
        return eventService.findById(id);
    }

    @PostMapping("/hashtag/stores/{store_id}")
    public Long saveHashtagEvent(@PathVariable Long store_id, @ModelAttribute HashtagEventSaveRequest event, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        return eventService.saveHashtagEvent(store_id, event, principal);
    }

    @PutMapping("/hashtag/{id}")
    public Long updateHashtagEvent(@PathVariable Long id, @ModelAttribute HashtagEventUpdateRequest requestDto, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        return eventService.updateHashtagEvent(id, requestDto, principal);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException  {
        eventService.softDelete(id, principal);
    }
}
