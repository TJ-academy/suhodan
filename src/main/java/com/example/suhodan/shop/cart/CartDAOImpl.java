package com.example.suhodan.shop.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CartDAOImpl implements CartDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<CartDTO> list(String user_id) {
		return sqlSession.selectList("cart.list", user_id);
	}

	@Override
	public void insert(CartDTO dto) {
		sqlSession.insert("cart.insert", dto);
	}

	@Override
	public void delete(int cart_id) {
		sqlSession.delete("cart.delete", cart_id);
	}

	@Override
	public void delete_all(String user_id) {
		sqlSession.delete("cart.delete_all", user_id);
	}

	@Override
	public int sum_money(String user_id) {
		return sqlSession.selectOne("cart.sum_money", user_id);
	}

	@Override
	public void modify(CartDTO dto) {
		sqlSession.update("cart.modify", dto);
	}
	
	@Override
	public CartDTO exists(String user_id, int goods_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("goods_id", goods_id);
		return sqlSession.selectOne("cart.exists", map);
	}
	
	@Override
	public void addAmount(CartDTO dto) {
		sqlSession.update("cart.addAmount", dto);
	}
}