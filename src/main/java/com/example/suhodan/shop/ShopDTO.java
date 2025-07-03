package com.example.suhodan.shop;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ShopDTO {
	private int reward_id;
	private String name;
	private String description;
	private String img;
    private int legend_id;
    private int price;
}
