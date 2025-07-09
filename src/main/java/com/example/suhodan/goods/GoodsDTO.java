package com.example.suhodan.goods;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class GoodsDTO {
	private int goods_id;
	private String name;
	private String description;
	private String img;
	private String detail_img;
	private String location;
	private int price;
	private Date reg_date;
	
	private MultipartFile imgFile;
	private MultipartFile detailImgFile;
}
