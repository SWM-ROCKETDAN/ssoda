package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.event.EventListResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreResponseDto;
import com.rocketdan.serviceserver.app.dto.store.StoreSaveRequestDto;
import com.rocketdan.serviceserver.app.dto.store.StoreUpdateRequestDto;
import com.rocketdan.serviceserver.domain.store.Store;
import com.rocketdan.serviceserver.domain.store.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class StoreService {
    private final StoreRepository storeRepository;

    @Transactional
    public Long save(StoreSaveRequestDto requestDto) {
        Store savedStore = requestDto.toEntity();
        return storeRepository.save(savedStore).getId();
    }

    @Transactional
    public Long update(Long id, StoreUpdateRequestDto requestDto) {
        Store store = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));
        store.update(requestDto.getName(), requestDto.getCategory(), requestDto.getAddress(), requestDto.getDescription(), requestDto.getImages());
        return id;
    }

    public StoreResponseDto findById(Long id) {
        Store entity = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));

        return new StoreResponseDto(entity);
    }

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

    @Transactional
    public void delete(Long id) {
        Store store = storeRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 가게가 없습니다. id=" + id));
        storeRepository.delete(store);
    }
}
