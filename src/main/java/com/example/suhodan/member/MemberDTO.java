package com.example.suhodan.member;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	private String user_id; //유저 ID
	private String passwd; 
	private String name;
	private String address;
	private Date join_date;
	private int total_donation; //총 기부금액
	private int badge_count; //획득한 배지 수
	private String gender;
	
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date birth;
}
