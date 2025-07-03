package com.example.suhodan.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<MemberDTO> list() {
		return sqlSession.selectList("member.list");
	}

	@Override
	public void insert(MemberDTO dto) {
		sqlSession.insert("member.insert", dto);
	}

	@Override
	public MemberDTO detail(String user_id) {
		return sqlSession.selectOne("member.detail", user_id);
	}

	@Override
	public void delete(String user_id) {
		sqlSession.delete("member.delete", user_id);
	}

	@Override
	public void update(MemberDTO dto) {
		sqlSession.update("member.update", dto);
	}

	@Override
	public boolean check_passwd(String user_id, String passwd) {
		boolean result = false;
		Map<String, String> map = new HashMap<>();
		map.put("user_id", user_id);
		map.put("passwd", passwd);
		int count = sqlSession.selectOne("member.check_passwd", map);
		
		if(count==1)
			result = true;
		return result;
	}
	
	@Override
	public boolean isUserIdExists(String user_id) {
		int count = sqlSession.selectOne("check_id_duplicate", user_id);
		return count > 0;
	}
	
	@Override
	public String login(MemberDTO dto) {
		return sqlSession.selectOne("member.login", dto);
	}

}
