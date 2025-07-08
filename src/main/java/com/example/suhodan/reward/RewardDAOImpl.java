package com.example.suhodan.reward;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.suhodan.legend.LegendDTO;

@Repository
public class RewardDAOImpl implements RewardDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<RewardDTO> list() {
		return sqlSession.selectList("reward.list");
	}
	
	@Override
	public List<RewardDTO> listPaging(Map<String, Integer> param) {
		return sqlSession.selectList("reward.listPaging", param);
	}
	
	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("legend.getTotalCount");
	}

	@Override
	public void insert(RewardDTO dto) {
		sqlSession.insert("reward.insert", dto);	
	}

	@Override
	public String img_file_info(int reward_id) {
		return sqlSession.selectOne("reward.img_file_info", reward_id);
	}
}
