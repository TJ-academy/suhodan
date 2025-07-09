package com.example.suhodan.badge;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BadgeDTO {
	private int badge_id;
	private String name;
	private String description;
	private String img;
	private Date reg_date;
	
	private MultipartFile imgFile;
}
