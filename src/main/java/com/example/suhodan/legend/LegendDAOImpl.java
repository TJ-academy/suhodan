package com.example.suhodan.legend;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LegendDAOImpl implements LegendDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<LegendDTO> list() {
		return sqlSession.selectList("legend.list");
	}
	
	@Override
	public List<LegendDTO> listPaging(Map<String, Integer> param) {
		return sqlSession.selectList("legend.listPaging", param);
	}
	
	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("legend.getTotalCount");
	}
	
	@Override
	public LegendDTO detail(int legend_id) {
		return sqlSession.selectOne("legend.detail", legend_id);
	}
	
	@Override
	public List<LegendDTO> list_location(String location) {
		return sqlSession.selectList("legend.list_location", location);
	}
	
	@Override
	public void insert(LegendDTO dto) {
		sqlSession.insert("legend.insert", dto);
	}
	
	@Override
	public void update(LegendDTO dto) {
		sqlSession.update("legend.update", dto);
	}

	@Override
	public void delete(int legend_id) {
		sqlSession.delete("legend.delete", legend_id);
	}
}
