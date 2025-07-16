package com.example.suhodan.orders;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderDTO {
	private int order_id;
	private String user_id;
	private Date order_date;
	private String order_status;
	private int order_amount;
	private String pay_method;
	private String refund_bank;
	private String refund_account;
	private String order_address1;
	private String order_address2;
	private String phone;
}
