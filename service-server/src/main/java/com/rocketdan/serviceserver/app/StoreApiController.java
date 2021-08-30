package com.rocketdan.serviceserver.app;

import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.event.hashtag.HashtagEventSaveRequest;
import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.store.StoreUpdateRequestDto;
import com.rocketdan.serviceserver.core.auth.LoginUser;
import com.rocketdan.serviceserver.s3.service.ImageManagerService;
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
    public Long save(@PathVariable Long user_id, @ModelAttribute StoreSaveRequestDto store, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        return storeService.save(user_id, store, principal);
    }

    @PutMapping("/{id}")
    public Long update(@PathVariable Long id, @ModelAttribute StoreUpdateRequestDto requestDto, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        return storeService.update(id, requestDto, principal);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Long id, @LoginUser org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException  {
        storeService.softDelete(id, principal);
    }
}
