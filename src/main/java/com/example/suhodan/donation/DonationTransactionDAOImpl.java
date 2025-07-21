package com.example.suhodan.donation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DonationTransactionDAOImpl implements DonationTransactionDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<DonationTransactionDTO> list() {
		return sqlSession.selectList("donationTrans.list");
	}
	
	@Override
	public List<DonationTransactionDTO> listPaging(Map<String, Integer> param) {
		return sqlSession.selectList("donationTrans.listPaging", param);
	}

	@Override
	public List<DonationListDTO> listPagingSearch(Map<String, Object> param) {
		return sqlSession.selectList("donationTrans.listPagingSearch", param);
	}
		
	@Override
	public int getTotalCount(String searchType, String searchKeyword) {
	    Map<String, String> param = new HashMap<>();
	    param.put("searchType", searchType);
	    param.put("searchKeyword", searchKeyword);
	    return sqlSession.selectOne("donationTrans.getTotalCount", param);
	}
	
	@Override
	public int getTransactionId(String imp_uid) {
		return sqlSession.selectOne("donationTrans.getTransactionId", imp_uid);
	}
}
