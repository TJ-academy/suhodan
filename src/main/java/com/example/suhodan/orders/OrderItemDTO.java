package com.example.suhodan.orders;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderItemDTO {
	private int orderId;
	private int productId;
	private String productName;
	private int quantity;
	private int unitPrice;
}
