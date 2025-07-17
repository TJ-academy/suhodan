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
	
	private int transaction_id;
	private int amount;
	private Date donation_date;
	
	private int project_id;
	private String project_title;
	private String project_img;
	private Date start_date;
	private Date end_date;
	private String location;
	
	private int reward_id;
	private int reward_count;
	private String reward_name;
	private String reward_desc;
	private String reward_img;
	private int goods_1;
	private int goods_2;
	private int goods_3;
	private int goods_4;
}
