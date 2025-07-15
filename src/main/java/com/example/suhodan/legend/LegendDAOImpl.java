package com.example.suhodan.legend;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.suhodan.goods.GoodsDTO;

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
	
	@Override
	public String img_file_info(int legend_id) {
		return sqlSession.selectOne("legend.img_file_info", legend_id);
	}
	
	@Override
	public String tts_file_info(int legend_id) {
		return sqlSession.selectOne("legend.tts_file_info", legend_id);
	}
	
	@Override
	public int getTotalCountSearch(Map<String, Object> param) {
	    return sqlSession.selectOne("legend.getTotalCountSearch", param);
	}
	
	@Override
	public List<LegendDTO> listPagingSearch(Map<String, Object> param) {
	    return sqlSession.selectList("legend.listPagingSearch", param);
	}
	
	@Override
	public List<LegendDTO> searchLegend(String option, String keyword) {
		Map<String, Object> param = new HashMap<>();
		param.put("option", option);
		param.put("keyword", "%" + keyword + "%"); //like 검색용
		return sqlSession.selectList("legend.searchLegend", param);
	}
}
