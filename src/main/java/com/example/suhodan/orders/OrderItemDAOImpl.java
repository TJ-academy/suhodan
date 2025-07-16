package com.example.suhodan.orders;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderItemDAOImpl implements OrderItemDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<OrderItemDTO> listByOrderId(int order_id) {
		return sqlSession.selectList("orderitem.listByOrderId", order_id);
	}

	@Override
	public void insertItems(List<OrderItemDTO> items) {
		sqlSession.insert("orderitem.insertItems", items);
	}

}
