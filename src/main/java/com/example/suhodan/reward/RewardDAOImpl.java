package com.example.suhodan.reward;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<RewardDTO> listPaging(Map<String, Integer> param) {
		return sqlSession.selectList("reward.listPaging", param);
	}
	
	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("reward.getTotalCount");
	}

	@Override
	public void insert(RewardDTO dto) {
		sqlSession.insert("reward.insert", dto);	
	}
	
	@Override
	public void update(RewardDTO dto) {
		sqlSession.update("reward.update", dto);
	}

	@Override
	public void delete(int reward_id) {
		sqlSession.delete("reward.delete", reward_id);
	}

	@Override
	public String img_file_info(int reward_id) {
		String img = sqlSession.selectOne("reward.img_file_info", reward_id);
	    return (img != null) ? img : "-"; // null 대신 기본값 "-" 반환
	}
	
	@Override
	public int getTotalCountSearch(Map<String, Object> param) {
	    return sqlSession.selectOne("reward.getTotalCountSearch", param);
	}
	
	@Override
	public List<RewardDTO> listPagingSearch(Map<String, Object> param) {
	    return sqlSession.selectList("reward.listPagingSearch", param);
	}
	
	@Override
	public RewardDTO getRewardDetailsById(int reward_id) {
        return sqlSession.selectOne("reward.selectRewardDetailsById", reward_id);
    }
	
	@Override
	public String getRewardName(Integer reward_id) {
	    return sqlSession.selectOne("reward.getRewardName", reward_id);
	}

	@Override
	public int getRewardId(String name) {
		return sqlSession.selectOne("reward.getRewardId", name);
	}
	
	@Override
	public void updateUserReward(int reward_id, String imp_uid) {
		Map<String, Object> map = new HashMap<>();
	    map.put("reward_id", reward_id);
	    map.put("imp_uid", imp_uid);
		sqlSession.update("reward.updateUserReward", map);
	}
}
