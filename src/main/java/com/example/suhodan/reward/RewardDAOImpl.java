package com.example.suhodan.reward;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RewardDAOImpl implements RewardDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<RewardDTO> list() {
		return sqlSession.selectList("reward.list");
	}

	@Override
	public void insert(RewardDTO dto) {
		sqlSession.insert("reward.insert", dto);	
	}

}
