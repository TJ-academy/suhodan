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
	public ShopDTO detail(int reward_id) {
		return sqlSession.selectOne("shop.detail", reward_id);
	}

	@Override
	public void update(ShopDTO dto) {
		sqlSession.update("shop.update", dto);
	}

	@Override
	public void delete(int reward_id) {
		sqlSession.delete("shop.delete", reward_id);
	}

	@Override
	public void insert(ShopDTO dto) {
		sqlSession.insert("shop.insert", dto);
	}
}