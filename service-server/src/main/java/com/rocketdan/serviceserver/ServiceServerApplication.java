package com.rocketdan.serviceserver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.retry.annotation.EnableRetry;

@EnableRetry
@SpringBootApplication
public class ServiceServerApplication {

	public static void main(String[] args) {
		SpringApplication.run(ServiceServerApplication.class, args);
	}

}
