package com.example.suhodan.orders;

import java.util.List;
import java.util.Map;

public interface OrderDAO {
	void order(OrderDTO dto); //주문 정보 삽입
	List<Map<String, Object>> getUserOrders(String user_id); //주문 내역 조회
	void delete(int order_id); //주문 취소
	void request_refund(int order_id); //환불요청처리
	OrderDTO refund_detail(int order_id); //환불요청 상세
	//관리자 기능
	List<OrderDTO> order_all ();
	OrderDTO order_detail(int order_id);
	void updateStatus(Map<String, Object> paramMap); 
	//배송조회
	List<Map<String, Object>> selectDeliveryStatus(String user_id);
	List<Map<String, Object>> detailDelivery(int order_id);
}
