package com.example.suhodan.shop;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAOImpl implements ShopDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ShopDTO> list(int start, int end, String category, String keyword, String sort) {
		Map<String, Object> map = new HashMap<>();
	    map.put("start", start);
	    map.put("end", end);
	    map.put("category", category);
		map.put("keyword", keyword);
		map.put("sort", sort);
		return sqlSession.selectList("shop.list", map);
	}
	
	@Override
	public int getShopCount(String category, String keyword) {
		Map<String, Object> map = new HashMap<>();
	    map.put("category", category);
	    map.put("keyword", keyword);
		return sqlSession.selectOne("shop.getShopCount", map);
	}
	
	@Override
	public ShopDTO detail(int goods_id) {
		return sqlSession.selectOne("shop.detail", goods_id);
	}
}