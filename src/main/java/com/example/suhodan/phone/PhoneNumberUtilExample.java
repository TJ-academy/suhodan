package com.example.suhodan.phone;

import com.google.i18n.phonenumbers.PhoneNumberUtil;
import com.google.i18n.phonenumbers.Phonenumber;

public class PhoneNumberUtilExample {

    public static boolean isValidPhoneNumber(String phoneNumber, String region) {
        try {
            PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.getInstance();
            Phonenumber.PhoneNumber number = phoneNumberUtil.parse(phoneNumber, region); // 국가 코드에 맞게 파싱
            return phoneNumberUtil.isValidNumber(number); // 유효성 검사
        } catch (Exception e) {
            return false; // 유효하지 않은 번호
        }
    }

    public static String formatPhoneNumber(String phoneNumber, String region) {
        try {
            PhoneNumberUtil phoneNumberUtil = PhoneNumberUtil.getInstance();
            Phonenumber.PhoneNumber number = phoneNumberUtil.parse(phoneNumber, region);
            return phoneNumberUtil.format(number, PhoneNumberUtil.PhoneNumberFormat.INTERNATIONAL); // 국제형식으로 포맷
        } catch (Exception e) {
            return null; // 잘못된 번호
        }
    }
}
