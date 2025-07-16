package com.example.suhodan.member.mypage;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MypageDTO {
	private int userbadge_id;
	private String user_id;
	
	private int badge_id;
	private Date get_date;
	private String badge_name;
	private String badge_desc;
	private String badge_img;
}
