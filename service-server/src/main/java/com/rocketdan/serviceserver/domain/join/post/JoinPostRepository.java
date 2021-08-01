package com.rocketdan.serviceserver.domain.join.post;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface JoinPostRepository extends JpaRepository<JoinPost, Long> {
}
