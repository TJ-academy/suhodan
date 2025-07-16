package com.example.suhodan.orders;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<OrderDTO> user_orders(String user_id) {
		return sqlSession.selectList("orders.list",user_id);
	}

	@Override
	public void order(OrderDTO dto) {
		sqlSession.insert("orders.order", dto);
	}

}
