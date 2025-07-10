package com.example.suhodan.shop;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ShopDTO {
	private int goods_id;
	private String name;
	private String description;
	private String img;
	private String detail_img;
    private int price;
    private String location;
}