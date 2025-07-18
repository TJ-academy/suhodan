package com.example.suhodan.orders;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void order(OrderDTO dto) {
		sqlSession.insert("orders.order", dto);
	}
	
	@Override
	public List<Map<String, Object>> getUserOrders(String user_id) {
		return sqlSession.selectList("orders.getUserOrders", user_id);
	}
	
	@Override
	public void delete(int order_id) {
		sqlSession.delete("orders.orderCancel", order_id);
	}
	
	@Override
	public void request_refund(int order_id) {
		sqlSession.update("orders.requestRefund", order_id);
	}
	
	@Override
	public OrderDTO refund_detail(int order_id) {
		return sqlSession.selectOne("orders.requestRefundDetail", order_id);
	}
	
	//관리자 기능
	@Override
	public List<OrderDTO> order_all() {
		return sqlSession.selectList("orders.order_all");
	}
	
	@Override
	public OrderDTO order_detail(int order_id) {
		return sqlSession.selectOne("orders.order_detail", order_id);
	}
	
	@Override
	public void updateStatus(Map<String, Object> paramMap) {
		sqlSession.update("orders.updateStatus", paramMap);
	}
	
	//배송조회
	@Override
	public List<Map<String, Object>> selectDeliveryStatus(String user_id) {
		return sqlSession.selectList("orders.selectDeliveryStatus", user_id);
	}
	
	@Override
	public List<Map<String, Object>> detailDelivery(int order_id) {
		return sqlSession.selectList("orders.detailDelivery", order_id);
	}
}
