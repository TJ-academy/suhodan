package com.example.suhodan.donation;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DonationHistoryDTO {
	private String title;
	private String content;
	private int amount;
	private Date donationDate;
}
