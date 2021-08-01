package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.domain.user.User;
import com.rocketdan.serviceserver.domain.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class UserService {
    private final UserRepository userRepository;

    @Transactional
    public List<StoreListResponseDto> getStoreListById(Long id) {
        User entity =  userRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. id=" + id));

        return entity.getStores().stream()
                .map(StoreListResponseDto::new)
                .collect(Collectors.toList());
    }
}
