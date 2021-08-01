package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.store.StoreUpdateRequestDto;
import com.rocketdan.serviceserver.service.StoreService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/stores")
public class StoreApiController {
    private final StoreService storeService;

    @GetMapping
    public List<StoreListResponseDto> retrieveAllStores() {
        return storeService.findAll();
    }

    @GetMapping("/{id}/events")
    public List<EventListResponseDto> retrieveEventListById(@PathVariable Long id) {
        return storeService.getEventListById(id);
    }

    @GetMapping("/{id}")
    public StoreResponseDto findById(@PathVariable Long id) {
        return storeService.findById(id);
    }

    @PostMapping("/users/{user_id}")
    public Long save(@PathVariable Long user_id, @RequestBody StoreSaveRequestDto store) {
        return storeService.save(user_id, store);
    }

    @PutMapping("/{id}")
    public Long update(@PathVariable Long id, @RequestBody StoreUpdateRequestDto requestDto) {
        return storeService.update(id, requestDto);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id) {
        storeService.delete(id);
    }
}
