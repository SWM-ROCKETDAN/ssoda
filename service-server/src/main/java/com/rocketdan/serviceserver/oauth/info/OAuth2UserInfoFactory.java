package com.rocketdan.serviceserver.oauth.info;

import com.rocketdan.serviceserver.domain.user.Provider;
import com.rocketdan.serviceserver.oauth.info.impl.KakaoOAuth2UserInfo;
import com.rocketdan.serviceserver.oauth.info.impl.NaverOAuth2UserInfo;

import java.util.Map;

public class OAuth2UserInfoFactory {
    public static OAuth2UserInfo getOAuth2UserInfo(Provider providerType, Map<String, Object> attributes) {
        switch (providerType) {
            case NAVER: return new NaverOAuth2UserInfo(attributes);
            case KAKAO: return new KakaoOAuth2UserInfo(attributes);
            default: throw new IllegalArgumentException("Invalid Provider Type.");
        }
    }
}

