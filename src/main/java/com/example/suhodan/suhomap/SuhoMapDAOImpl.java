package com.example.suhodan.suhomap;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SuhoMapDAOImpl implements SuhoMapDAO {
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<SuhoMapDTO> list_all() {
		return sqlSession.selectList("suhoMap.list_all");
	}

	@Override
	public List<SuhoMapDTO> detail_sido(String sido) {
		return sqlSession.selectList("suhoMap.detail_sido", sido);
	}

	@Override
	public List<SuhoMapDTO> detail_class(String danger_class) {
		return sqlSession.selectList("suhoMap.detail_class", danger_class);
	}

}
