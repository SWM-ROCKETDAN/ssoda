package com.rocketdan.serviceserver.domain.join.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface JoinUserRepository extends JpaRepository<JoinUser, Long> {
    Optional<JoinUser> findBySnsIdAndType(String snsId, Integer type);
}
