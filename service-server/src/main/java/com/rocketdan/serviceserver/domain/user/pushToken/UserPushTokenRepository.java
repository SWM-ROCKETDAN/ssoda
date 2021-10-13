package com.rocketdan.serviceserver.domain.user.pushToken;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserPushTokenRepository extends JpaRepository<UserPushToken, Long> {
    Optional<UserPushToken> findByUserId(String userId);
}
