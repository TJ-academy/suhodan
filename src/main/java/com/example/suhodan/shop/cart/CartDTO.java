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
	private int goods_id;
	private String goods_name;
	private int goods_price;
	private String goods_img;
	private int amount;
	private int money;
}