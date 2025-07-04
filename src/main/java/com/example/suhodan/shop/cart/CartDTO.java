package com.example.suhodan.shop.cart;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CartDTO {
	private int cart_id;
	private String user_id;
	private String user_name;
	private int reward_id;
	private String reward_name;
	private int reward_price;
	private String reward_img;
	private int amount;
	private int money;
}