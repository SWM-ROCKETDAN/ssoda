package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.resource.NoAuthorityToResourceException;
import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.store.StoreUpdateRequestDto;
import com.rocketdan.serviceserver.config.auth.UserIdValidCheck;
import com.rocketdan.serviceserver.domain.store.Store;
import com.rocketdan.serviceserver.domain.store.StoreRepository;
import com.rocketdan.serviceserver.domain.user.User;
import com.rocketdan.serviceserver.domain.user.UserRepository;
import com.rocketdan.serviceserver.s3.service.ImageManagerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class StoreService {
    private final StoreRepository storeRepository;
    private final UserRepository userRepository;

    private final ImageManagerService imageManagerService;

    private final UserIdValidCheck userIdValidCheck;

    @Transactional
    public Long save(Long user_id, StoreSaveRequestDto requestDto, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        User linkedUser = userRepository.findById(user_id).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. id=" + user_id));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(linkedUser.getUserId(), principal);

        List<String> imgPaths = imageManagerService.upload("image/store", requestDto.getImages());
        Store savedStore = requestDto.toEntity(imgPaths);
        savedStore.setUser(linkedUser);

        return storeRepository.save(savedStore).getId();
    }

    @Transactional
    public Long update(Long id, StoreUpdateRequestDto requestDto, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Store store = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(store.getUser().getUserId(), principal);

        imageManagerService.delete(store.getImages());
        List<String> imgPaths = imageManagerService.upload("image/store", requestDto.getImages());

        store.update(requestDto.getName(), requestDto.getCategory(), requestDto.getAddress(), requestDto.getDescription(), imgPaths);
        return id;
    }

    @Transactional(readOnly = true)
    public StoreResponseDto findById(Long id) {
        Store entity = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));

        return new StoreResponseDto(entity);
    }

    @Transactional(readOnly = true)
    public List<EventListResponseDto> getEventListById(Long id) {
        Store entity = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));

        return entity.getEvents().stream()
                .map(EventListResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<StoreListResponseDto> findAll() {
        return storeRepository.findAll().stream()
                .map(StoreListResponseDto::new)
                .collect(Collectors.toList());
    }

    public void softDelete(Long id, org.springframework.security.core.userdetails.User principal) throws NoAuthorityToResourceException {
        Store store = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));

        // valid 하지 않으면 exception 발생
        userIdValidCheck.userIdValidCheck(store.getUser().getUserId(), principal);

        storeRepository.delete(store);
    }
}
