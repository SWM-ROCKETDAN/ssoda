package com.rocketdan.serviceserver.domain.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRefreshTokenRepository extends JpaRepository<UserRefreshToken, Long> {
    Optional<UserRefreshToken> findByUserId(String userId);
    Optional<UserRefreshToken> findByUserIdAndRefreshToken(String userId, String refreshToken);
}
