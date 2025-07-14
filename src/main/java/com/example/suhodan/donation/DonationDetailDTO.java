package com.example.suhodan.donation;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DonationDetailDTO {
	private String title;
	private String filename;
	private Date startDate;
	private Date endDate;
	private String location;
	private String paymentMethod;
	private int amount;
	private Date donationDate;
}
