package com.example.suhodan.orders;

import java.util.List;
import java.util.Map;

public interface OrderDAO {
	void order(OrderDTO dto); //주문 정보 삽입
	List<Map<String, Object>> getUserOrders(String user_id); //주문 내역 조회
	void delete(int order_id); //주문 취소
}
