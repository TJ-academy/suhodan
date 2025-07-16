package com.example.suhodan.phone;

import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;
import com.twilio.rest.api.v2010.account.Message;
import com.twilio.type.PhoneNumber;
import org.springframework.beans.factory.annotation.Value; // @Value 임포트
import org.springframework.stereotype.Service;

@Service
public class PhoneVerificationService {

    @Value("${twilio.phone.number}") // application.properties의 Twilio 발신 번호 주입
    private String twilioPhoneNumber;

    // 인증 코드 발송 메서드
    public String sendVerificationCode(String toPhoneNumber) {
        // 1. 전화번호 유효성 검사 (libphonenumber 사용)
        // 한국 전화번호 기준 (KR), 필요에 따라 "KR" 대신 다른 국가 코드 사용
        if (!PhoneNumberUtilExample.isValidPhoneNumber(toPhoneNumber, "KR")) {
            System.err.println("유효하지 않은 전화번호 형식: " + toPhoneNumber);
            return null;
        }

        // 2. 전화번호 국제 형식으로 포맷팅 (Twilio는 국제 형식을 선호)
        String formattedPhoneNumber = PhoneNumberUtilExample.formatPhoneNumber(toPhoneNumber, "KR");
        if (formattedPhoneNumber == null) {
            System.err.println("전화번호 포맷팅 실패: " + toPhoneNumber);
            return null;
        }

        // 랜덤 6자리 인증 코드 생성
        String verificationCode = generateVerificationCode();

        try {
            // SMS 보내기
            Message message = Message.creator(
                    new PhoneNumber(formattedPhoneNumber), // 수신자의 전화번호 (국제 형식)
                    new PhoneNumber(twilioPhoneNumber),   // 발신자의 Twilio 전화번호
                    "인증 코드: " + verificationCode + " (수호단)" // 전송할 메시지 내용 (Twilio 테스트 계정은 메시지 끝에 "Sent from your Twilio trial account"가 자동으로 붙습니다.)
            ).create();

            System.out.println("Message SID: " + message.getSid());
            return verificationCode;  // 인증 코드를 반환 (후에 사용자가 입력한 값과 비교할 수 있도록)
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Twilio SMS 발송 중 오류 발생: " + e.getMessage());
            return null;  // 오류 발생 시 null 반환
        }
    }

    // 랜덤 6자리 인증 코드 생성
    private String generateVerificationCode() {
        int code = (int) (Math.random() * 900000) + 100000;  // 100000 ~ 999999 사이의 숫자 생성
        return String.valueOf(code);
    }
}