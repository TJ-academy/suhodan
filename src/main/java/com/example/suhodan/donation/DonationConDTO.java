package com.example.suhodan.donation;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DonationConDTO {
	private int content_id;
	private String title;
	private String content;
	private int target_amount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date start_date;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date end_date;
	private String location;
	private Date created_at;
	private String filename;
	private MultipartFile file1;
	private int donated_amount; //누적 후원금액
	//private long dDay; //D-DAY
	private long dday;
	
	private int rewarda;
	private int rewardb;
	private int rewardc;
	private int rewardd;
	private String rewarda_name;
	private String rewardb_name;
	private String rewardc_name;
	private String rewardd_name;
}