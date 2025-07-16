package com.example.suhodan.orders;

import java.util.List;

public interface OrderDAO {
	List<OrderDTO> user_orders(String user_id); //주문 내역 조회(유저)
	void order(OrderDTO dto); //주문 정보 삽입
}
