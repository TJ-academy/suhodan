package com.example.suhodan.phone;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

import com.twilio.Twilio;

import jakarta.annotation.PostConstruct;

@Configuration
public class TwilioConfig {

    @Value("${twilio.account.sid}") // application.properties의 값 주입
    private String accountSid;

    @Value("${twilio.auth.token}") // application.properties의 값 주입
    private String authToken;

    @PostConstruct
    public void init() {
        // Twilio 초기화 시 주입받은 값 사용
        Twilio.init(accountSid, authToken);
        System.out.println("Twilio SDK initialized with SID: " + accountSid); // 초기화 확인용
    }
}