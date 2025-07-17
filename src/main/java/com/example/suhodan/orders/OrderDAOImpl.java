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

}
