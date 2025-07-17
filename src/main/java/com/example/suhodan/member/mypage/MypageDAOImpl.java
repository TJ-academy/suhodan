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
	public MypageDTO badgeDetail(int userbadge_id) {
		return sqlSession.selectOne("mypage.badgeDetail", userbadge_id);
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
	
	@Override
	public List<MypageDTO> donationList(String donor_id, int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
	    map.put("donor_id", donor_id);
	    map.put("startRow", startRow);
	    map.put("endRow", endRow);
	    return sqlSession.selectList("mypage.donationList", map);
	}
	
	@Override
	public MypageDTO donationDetail(int transaction_id) {
		return sqlSession.selectOne("mypage.donationDetail", transaction_id);
	}
	
	@Override
	public List<MypageDTO> rewardList(String user_id, int startRow, int endRow) {
		Map<String, Object> map = new HashMap<>();
	    map.put("user_id", user_id);
	    map.put("startRow", startRow);
	    map.put("endRow", endRow);
	    return sqlSession.selectList("mypage.rewardList", map);
	}
	
	@Override
	public MypageDTO rewardDetail(int transaction_id) {
		return sqlSession.selectOne("mypage.rewardDetail", transaction_id);
	}
}
