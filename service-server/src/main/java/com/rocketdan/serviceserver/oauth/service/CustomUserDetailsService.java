package com.rocketdan.serviceserver.oauth.service;

import com.rocketdan.serviceserver.domain.user.User;
import com.rocketdan.serviceserver.domain.user.UserPrincipal;
import com.rocketdan.serviceserver.domain.user.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUserIdAndDeleted(username, false).orElseThrow(() -> new UsernameNotFoundException("해당 유저가 없습니다. userId=" + username));
        return UserPrincipal.create(user);
    }
}
