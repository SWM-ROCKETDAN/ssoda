package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.store.StoreSaveRequestDto;
import com.rocketdan.serviceserver.domain.store.Store;
import com.rocketdan.serviceserver.domain.store.StoreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class StoreService {
    private final StoreRepository storeRepository;

    @Transactional
    public Long save(StoreSaveRequestDto requestDto) {
        Store savedStore = requestDto.toEntity();
        return storeRepository.save(savedStore).getId();
    }

}
