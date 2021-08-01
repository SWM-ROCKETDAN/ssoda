package com.rocketdan.serviceserver.domain.join.user;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface JoinUserRepository extends JpaRepository<JoinUser, Long> {
}
