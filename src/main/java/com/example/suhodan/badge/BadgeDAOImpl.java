package com.example.suhodan.badge;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BadgeDAOImpl implements BadgeDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<BadgeDTO> list() {
		return sqlSession.selectList("badge.list");
	}

	@Override
	public void insert(BadgeDTO dto) {
		sqlSession.insert("badge.insert", dto);		
	}

}
