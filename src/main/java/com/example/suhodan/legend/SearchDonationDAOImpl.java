package com.example.suhodan.legend;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SearchDonationDAOImpl implements SearchDonationDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<SearchDonationDTO> searchFromLocation(String location) {
		return sqlSession.selectList("legend.searchFromLocation", location);
	}

}
