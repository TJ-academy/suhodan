package com.example.suhodan.member.mypage;

import java.util.List;

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

}
