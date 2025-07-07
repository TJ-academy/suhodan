package com.example.suhodan.donation;

import java.util.Date;

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
	private Date start_date;
	private Date end_date;
	private String location;
	private Date created_at;
	private String filename;
	private MultipartFile file1;
}
