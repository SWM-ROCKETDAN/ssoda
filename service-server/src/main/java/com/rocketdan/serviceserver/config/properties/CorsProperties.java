package com.rocketdan.serviceserver.config.properties;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@ConfigurationProperties(prefix = "cors")
@Configuration
@Getter
@Setter
public class CorsProperties {
    private String allowedOrigins;
    private String allowedMethods;
    private String allowedHeaders;
    private Long maxAge;
}
