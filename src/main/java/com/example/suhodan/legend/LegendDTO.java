package com.example.suhodan.legend;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class LegendDTO {
	private int legend_id;
	private String title;
	private String story;
	private String tts_audio;
	private String img;
	private String location;
	private Date reg_date;
	private String source;
	
	private MultipartFile imgFile;
	private MultipartFile ttsAudioFile;
}
