package com.example.suhodan.member.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MypageDAOImpl implements MypageDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<MypageDTO> getUserBadge(String user_id) {
		return sqlSession.selectList("mypage.getUserBadge", user_id);
	}
	
	@Override
	public MypageDTO badgeDetail(String user_id, int badge_id) {
		Map<String, Object> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("badge_id", badge_id);
		return sqlSession.selectOne("mypage.badgeDetail", map);
	}
	
	@Override
	public List<MypageDTO> getUserBadgesPaged(String user_id, int startRow, int endRow) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("user_id", user_id);
	    map.put("startRow", startRow);
	    map.put("endRow", endRow);
	    return sqlSession.selectList("mypage.getUserBadgesPaged", map);
	}

	@Override
	public int getUserBadgeCount(String user_id) {
	    return sqlSession.selectOne("mypage.getUserBadgeCount", user_id);
	}
	
	
}
