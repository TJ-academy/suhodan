package com.example.suhodan.orders;

import java.util.List;

public interface OrderItemDAO {
	//주문 번호로 주문 상세 목록 조회
	List<OrderItemDTO> listByOrderId(int order_id);
	//order_id, product_id들 받아와서 insert
	void insertItems(List<OrderItemDTO> items);
}
