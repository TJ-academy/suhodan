package com.example.suhodan.suhomap;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SuhoMapDTO {
	private String location;
	private String sido;
	private double danger;
	private String danger_class;
}
