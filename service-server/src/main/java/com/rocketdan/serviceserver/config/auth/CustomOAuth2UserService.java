package com.rocketdan.serviceserver.config.auth;

import com.rocketdan.serviceserver.Exception.auth.CustomAuthenticationException;
import com.rocketdan.serviceserver.Exception.auth.LoginFailedException;
import com.rocketdan.serviceserver.domain.user.*;
import com.rocketdan.serviceserver.oauth.info.OAuth2UserInfo;
import com.rocketdan.serviceserver.oauth.info.OAuth2UserInfoFactory;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private final UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        try {
            return this.process(userRequest, oAuth2User);
        } catch (CustomAuthenticationException ex) {
            throw ex;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new InternalAuthenticationServiceException(ex.getMessage(), ex.getCause());
        }
    }

    private OAuth2User process(OAuth2UserRequest userRequest, OAuth2User user) {
        // 현재 로그인을 진행중인 서비스를 구분
        Provider provider = Provider.valueOf(userRequest.getClientRegistration().getRegistrationId().toUpperCase());

        OAuth2UserInfo userInfo = OAuth2UserInfoFactory.getOAuth2UserInfo(provider, user.getAttributes());
        Optional<User> savedUser = userRepository.findByUserId(userInfo.getId());

        // 이미 있으면 update
        if (savedUser.isPresent()) {
            // 저장된 user의 provider와 로그인한 provider가 다를 경우
            if (provider != savedUser.get().getProvider()) {
                throw new LoginFailedException();
//                throw new OAuthProviderMissMatchException(
//                        "Looks like you're signed up with " + provider +
//                                " account. Please use your " + savedUser.getProviderType() + " account to login."
//                );
            }
            updateUser(savedUser.get(), userInfo);
            return UserPrincipal.create(savedUser.get(), user.getAttributes());
        } else { // 신규 유저면 create
            return UserPrincipal.create(createUser(userInfo, provider), user.getAttributes());
        }
    }

    private User createUser(OAuth2UserInfo userInfo, Provider provider) {
        Date now = new Date();

        User user = User.builder()
                .userId(userInfo.getId())
                .name(userInfo.getName())
                .email(userInfo.getEmail())
                .password("Y")
                .picture(userInfo.getImageUrl())
                .provider(provider)
                .role(Role.USER)
                .createdDate(now)
                .modifiedDate(now)
                .build();

        return userRepository.saveAndFlush(user);
    }

    private User updateUser(User user, OAuth2UserInfo userInfo) {
        user.update(userInfo.getName(), userInfo.getImageUrl());
        return user;
    }
}

