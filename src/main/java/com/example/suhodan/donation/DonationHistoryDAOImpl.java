package com.example.suhodan.donation;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DonationHistoryDAOImpl implements DonationHistoryDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<DonationHistoryDTO> list(String donor_id) {
		return sqlSession.selectList("mypage.myDonationHistory", donor_id);
	}

}
