package com.example.suhodan.reward;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RewardDTO {
	private int reward_id;
	private String name;
	private String description;
	private String price_type;
	private String img;
	private Integer goods_1;
	private Integer goods_2;
	private Integer goods_3;
	private Integer goods_4;
	private Date reg_date;
	
	private String goods_1_name;
	private String goods_2_name;
	private String goods_3_name;
	private String goods_4_name;
	
	private MultipartFile imgFile;
}
