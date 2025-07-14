package com.example.suhodan.badge;

import java.util.List;
import java.util.Map;

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
	public List<BadgeDTO> listPaging(Map<String, Integer> param) {
		return sqlSession.selectList("badge.listPaging", param);
	}

	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("badge.getTotalCount");
	}

	@Override
	public void insert(BadgeDTO dto) {
		sqlSession.insert("badge.insert", dto);		
	}

	@Override
	public void update(BadgeDTO dto) {
		sqlSession.update("badge.update", dto);
	}

	@Override
	public void delete(int badge_id) {
		sqlSession.delete("badge.delete", badge_id);
	}

	@Override
	public String img_file_info(int badge_id) {
		return sqlSession.selectOne("badge.img_file_info", badge_id);
	}
	
	@Override
	public int getTotalCountSearch(Map<String, Object> param) {
	    return sqlSession.selectOne("badge.getTotalCountSearch", param);
	}
	
	@Override
	public List<BadgeDTO> listPagingSearch(Map<String, Object> param) {
	    return sqlSession.selectList("badge.listPagingSearch", param);
	}
}
