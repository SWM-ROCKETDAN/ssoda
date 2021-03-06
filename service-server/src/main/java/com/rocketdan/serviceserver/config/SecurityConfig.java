package com.rocketdan.serviceserver.config;

import com.rocketdan.serviceserver.Exception.auth.RestAuthenticationEntryPoint;
import com.rocketdan.serviceserver.config.auth.CustomOAuth2UserService;
import com.rocketdan.serviceserver.config.properties.AppProperties;
import com.rocketdan.serviceserver.config.properties.CorsProperties;
import com.rocketdan.serviceserver.domain.user.Role;
import com.rocketdan.serviceserver.oauth.filter.TokenAuthenticationFilter;
import com.rocketdan.serviceserver.oauth.handler.OAuth2AuthenticationFailureHandler;
import com.rocketdan.serviceserver.oauth.handler.OAuth2AuthenticationSuccessHandler;
import com.rocketdan.serviceserver.oauth.handler.RedirectingLogoutSuccessHandler;
import com.rocketdan.serviceserver.oauth.handler.TokenAccessDeniedHandler;
import com.rocketdan.serviceserver.oauth.repository.OAuth2AuthorizationRequestBasedOnCookieRepository;
import com.rocketdan.serviceserver.oauth.service.CustomUserDetailsService;
import com.rocketdan.serviceserver.provider.security.JwtAuthTokenProvider;
import com.rocketdan.serviceserver.service.UserRefreshTokenService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsUtils;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final CorsProperties corsProperties;
    private final AppProperties appProperties;
    private final JwtAuthTokenProvider jwtAuthTokenProvider;
    private final CustomUserDetailsService userDetailsService;
    private final CustomOAuth2UserService oAuth2UserService;
    private final TokenAccessDeniedHandler tokenAccessDeniedHandler;
    private final UserRefreshTokenService userRefreshTokenService;

    /*
     * UserDetailsService ??????
     * */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder());
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .cors()
                .and()
                    .sessionManagement()
                    .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                    .csrf().disable()
                    .formLogin().disable()
                    .httpBasic().disable()
                    .exceptionHandling()
                    // ????????? ???????????? ???????????? ?????? ???????????? ??????????????? ?????? ??????????????????.
                    // ????????? ?????????????????? ??????????????? ????????????(Authorization)??? ????????? ???????????? ?????? 401(UnAuthorized) ?????? ???????????? ?????????
                    // ?????? ??????????????? ????????? authenticationEntryPoint
                    .authenticationEntryPoint(new RestAuthenticationEntryPoint())
                    .accessDeniedHandler(tokenAccessDeniedHandler)
                .and()
                    .authorizeRequests()
                    .requestMatchers(CorsUtils::isPreFlightRequest).permitAll()
                    .antMatchers(HttpMethod.GET, "/api/v1/events/**", "/api/v1/stores/**", "**login**", "/favicon.ico", "/api/v1/auth/**").permitAll()
                    .antMatchers(HttpMethod.POST, "/api/v1/join/events/**", "/api/v1/push/**").permitAll()
                    .antMatchers(HttpMethod.PUT, "/api/v1/join/posts/**").permitAll()
                    .antMatchers("/api/v1/**").hasAnyAuthority(Role.USER.getCode())
                    .antMatchers("/api/**/admin/**").hasAnyAuthority(Role.ADMIN.getCode())
                    // ???????????? ????????? ???????????? ?????? ??????
                    .anyRequest().authenticated()
                .and()
                    .logout()
                    .logoutSuccessHandler(redirectingLogoutSuccessHandler())
                .and()
                    // oauth2 ?????? ??????
                    .oauth2Login()
                    .authorizationEndpoint()
                    .baseUri("/oauth2/authorization")
                    .authorizationRequestRepository(oAuth2AuthorizationRequestBasedOnCookieRepository())
                .and()
                    .redirectionEndpoint()
                    .baseUri("/*/oauth2/code/*")
                .and()
                    // oauth2 ????????? ?????? ?????? ????????? ????????? ????????? ?????? ??????
                    .userInfoEndpoint()
                    .userService(oAuth2UserService)
                .and()
                    .successHandler(oAuth2AuthenticationSuccessHandler())
                    .failureHandler(oAuth2AuthenticationFailureHandler());

        http.addFilterBefore(tokenAuthenticationFilter(), UsernamePasswordAuthenticationFilter.class);
    }

    /*
     * auth ????????? ??????
     * */
    @Override
    @Bean(BeanIds.AUTHENTICATION_MANAGER)
    protected AuthenticationManager authenticationManager() throws Exception {
        return super.authenticationManager();
    }

    /*
     * security ?????? ???, ????????? ????????? ??????
     * */
    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /*
     * ?????? ?????? ??????
     * */
    @Bean
    public TokenAuthenticationFilter tokenAuthenticationFilter() {
        return new TokenAuthenticationFilter(jwtAuthTokenProvider);
    }

    /*
     * ?????? ?????? ?????? Repository
     * ?????? ????????? ?????? ?????? ????????? ??? ??????.
     * */
    @Bean
    public OAuth2AuthorizationRequestBasedOnCookieRepository oAuth2AuthorizationRequestBasedOnCookieRepository() {
        return new OAuth2AuthorizationRequestBasedOnCookieRepository();
    }

    /*
     * Oauth ?????? ?????? ?????????
     * */
    @Bean
    public OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler() {
        return new OAuth2AuthenticationSuccessHandler(
                jwtAuthTokenProvider,
                appProperties,
                userRefreshTokenService,
                oAuth2AuthorizationRequestBasedOnCookieRepository()
        );
    }

    /*
     * Oauth ?????? ?????? ?????????
     * */
    @Bean
    public OAuth2AuthenticationFailureHandler oAuth2AuthenticationFailureHandler() {
        return new OAuth2AuthenticationFailureHandler(oAuth2AuthorizationRequestBasedOnCookieRepository());
    }

    /*
    * Logout ?????? ?????????
    * */
    @Bean
    public RedirectingLogoutSuccessHandler redirectingLogoutSuccessHandler() {
        return new RedirectingLogoutSuccessHandler();
    }

    /*
     * Cors ??????
     * */
    @Bean
    public UrlBasedCorsConfigurationSource corsConfigurationSource() {
        UrlBasedCorsConfigurationSource corsConfigSource = new UrlBasedCorsConfigurationSource();

        CorsConfiguration corsConfig = new CorsConfiguration();
        corsConfig.setAllowedHeaders(Arrays.asList(corsProperties.getAllowedHeaders().split(",")));
        corsConfig.setAllowedMethods(Arrays.asList(corsProperties.getAllowedMethods().split(",")));
        corsConfig.setAllowedOrigins(Arrays.asList(corsProperties.getAllowedOrigins().split(",")));
        corsConfig.setAllowCredentials(true);
        corsConfig.setMaxAge(corsConfig.getMaxAge());

        corsConfigSource.registerCorsConfiguration("/**", corsConfig);
        return corsConfigSource;
    }
}

