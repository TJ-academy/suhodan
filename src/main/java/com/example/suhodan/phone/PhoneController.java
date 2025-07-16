package com.example.suhodan.phone;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody; // @RequestBody 임포트
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/mypage/phone")
public class PhoneController {

    @Autowired
    private PhoneVerificationService phoneVerificationService;

    // 사용자 전화번호와 인증 코드를 저장할 Map (실제 서비스에서는 Redis나 DB 사용 권장)
    private static final Map<String, String> verificationCodes = new HashMap<>();

    // 인증 코드 발송 API
    @PostMapping("/send.do")
    // @RequestBody를 사용하여 JSON 요청 본문 파싱
    public Map<String, String> send(@RequestBody Map<String, String> payload) {
        String phoneNumber = payload.get("phoneNumber"); // JSON에서 phoneNumber 추출
        Map<String, String> response = new HashMap<>();

        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            response.put("status", "error");
            response.put("message", "전화번호를 입력해주세요.");
            return response;
        }

        // 인증 코드를 생성하고 발송
        String verificationCode = phoneVerificationService.sendVerificationCode(phoneNumber);

        if (verificationCode != null) {
            // 인증 코드를 저장 (전화번호와 코드)
            verificationCodes.put(phoneNumber, verificationCode);
            response.put("status", "success");
            response.put("message", "인증 코드가 발송되었습니다.");
            System.out.println("DEBUG: Code sent for " + phoneNumber + " is " + verificationCode); // 디버그용
        } else {
            response.put("status", "error");
            response.put("message", "인증 코드 발송 실패. 전화번호 형식을 확인하거나 잠시 후 다시 시도해주세요.");
        }
        return response;
    }

    // 인증 코드 확인 API
    @PostMapping("/verify.do")
    // @RequestBody를 사용하여 JSON 요청 본문 파싱
    public Map<String, String> verify(@RequestBody Map<String, String> payload) {
        String phoneNumber = payload.get("phoneNumber"); // JSON에서 phoneNumber 추출
        String code = payload.get("code");               // JSON에서 code 추출
        Map<String, String> response = new HashMap<>();

        if (phoneNumber == null || phoneNumber.trim().isEmpty() || code == null || code.trim().isEmpty()) {
            response.put("status", "error");
            response.put("message", "전화번호와 인증 코드를 모두 입력해주세요.");
            return response;
        }

        // 입력된 코드가 저장된 코드와 일치하는지 확인
        String savedCode = verificationCodes.get(phoneNumber);

        if (savedCode != null && savedCode.equals(code)) {
            // 성공 시, 저장된 인증 코드는 삭제하는 것이 좋습니다.
            verificationCodes.remove(phoneNumber);
            response.put("status", "success");
            response.put("message", "인증 성공!");
        } else {
            response.put("status", "error");
            response.put("message", "인증 코드가 일치하지 않거나 만료되었습니다.");
        }
        return response;
    }
}