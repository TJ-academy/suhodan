package com.example.suhodan.legend;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LegendDTO {
	private int legend_id;
	private String title;
	private String story;
	private MultipartFile tts_audio;
	private MultipartFile img;
	private String location;
	private Date reg_date;
	
	private String imgFileName;
	private String ttsAudioFileName;
}
