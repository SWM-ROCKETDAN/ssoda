package com.rocketdan.serviceserver.service;

import com.rocketdan.serviceserver.Exception.auth.token.CustomRefreshTokenException;
import com.rocketdan.serviceserver.domain.user.refreshToken.UserRefreshToken;
import com.rocketdan.serviceserver.domain.user.refreshToken.UserRefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class UserRefreshTokenService {
    private final UserRefreshTokenRepository userRefreshTokenRepository;

    @Transactional
    public void saveAndFlush(UserRefreshToken userRefreshToken) {
        userRefreshTokenRepository.saveAndFlush(userRefreshToken);
    }

    @Transactional
    public Long update(String userId, String newRefreshToken) {
        UserRefreshToken userRefreshToken = userRefreshTokenRepository.findByUserId(userId).orElseThrow(CustomRefreshTokenException::new);
        userRefreshToken.updateRefreshToken(newRefreshToken);
        return userRefreshToken.getId();
    }

    @Transactional
    public void saveOrUpdate(String userId, String newRefreshToken) {
        Optional<UserRefreshToken> optionalUserRefreshToken = userRefreshTokenRepository.findByUserId(userId);

        if (optionalUserRefreshToken.isPresent()) {
            UserRefreshToken userRefreshToken = optionalUserRefreshToken.get();
            userRefreshToken.updateRefreshToken(newRefreshToken);
        } else {
            userRefreshTokenRepository.saveAndFlush(new UserRefreshToken(userId, newRefreshToken));
        }
    }

    @Transactional(readOnly = true)
    public boolean checkValid(String userId, String refreshToken){
        return userRefreshTokenRepository.findByUserIdAndRefreshToken(userId, refreshToken).isPresent();
    }
}
