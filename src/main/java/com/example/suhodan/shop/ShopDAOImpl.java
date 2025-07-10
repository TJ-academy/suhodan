package com.example.suhodan.shop;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAOImpl implements ShopDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ShopDTO> list() {
		return sqlSession.selectList("shop.list");
	}

	@Override
	public ShopDTO detail(int goods_id) {
		return sqlSession.selectOne("shop.detail", goods_id);
	}
}