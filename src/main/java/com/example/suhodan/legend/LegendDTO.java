package com.example.suhodan.legend;

import lombok.Data;

@Data
public class LegendDTO {
	private int legend_id;
	private String title;
	private String story;
	private String tts_audio;
	private String img;
	private String location;
}
