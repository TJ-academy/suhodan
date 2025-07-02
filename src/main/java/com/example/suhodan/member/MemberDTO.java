package com.example.suhodan.member;

import java.util.Date;

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
	private Date join_date;
	private int total_donation; //총 기부금액
	private int badge_count; //획득한 배지 수
	//insert into suho_user (user_id, passwd, name, address) values ('kim', MYPACK.ENCRYPT('1234'), '김철수', '서울특별시 종로구');
}
