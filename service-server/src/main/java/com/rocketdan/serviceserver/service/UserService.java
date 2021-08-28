package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.app.dto.store.StoreListResponseDto;
import com.rocketdan.serviceserver.app.dto.user.UserResponseDto;
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
    public List<StoreListResponseDto> getStoreListById(String userId) {
        User entity = userRepository.findByUserId(userId).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. userId=" + userId));

        return entity.getStores().stream()
                .map(StoreListResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public UserResponseDto findByUserId(String userId) {
        User entity = userRepository.findByUserId(userId).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. userId=" + userId));

        return new UserResponseDto(entity);
    }
}
