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

    @Transactional(readOnly = true)
    public List<StoreListResponseDto> getStoreListById(String userId) {
        User entity = userRepository.findByUserIdAndDeleted(userId, false).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. userId=" + userId));

        return entity.getStores().stream()
                .map(StoreListResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public UserResponseDto findByUserId(String userId) {
        User entity = userRepository.findByUserIdAndDeleted(userId, false).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. userId=" + userId));

        return new UserResponseDto(entity);
    }

    public void delete(String userId) {
        User user = userRepository.findByUserIdAndDeleted(userId, false).orElseThrow(() -> new IllegalArgumentException("해당 유저가 없습니다. userId=" + userId));
        userRepository.delete(user);
    }
}
