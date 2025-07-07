package com.example.suhodan.reward;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RewardDTO {
	private int reward_id;
	private String name;
	private String description;
	private String img;
	private int legend_id;
	
	private MultipartFile imgFile;
}
