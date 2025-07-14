package com.example.suhodan.reward;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RewardDTO {
	private int reward_id;
	private String name;
	private String description;
	private String price_type;
	private String img;
	private int goods_1;
	private int goods_2;
	private int goods_3;
	private int goods_4;
	
	private String goods_1_name;
	private String goods_2_name;
	private String goods_3_name;
	private String goods_4_name;
	
	private MultipartFile imgFile;
}
