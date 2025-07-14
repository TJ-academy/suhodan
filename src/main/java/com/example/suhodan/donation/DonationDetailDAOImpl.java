package com.example.suhodan.donation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DonationDetailDAOImpl implements DonationDetailDAO {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<DonationDetailDTO> getDetail(int contentId, String donorId) {
	    Map<String, Object> param = new HashMap<>();
	    param.put("contentId", contentId);
	    param.put("donorId", donorId);
	    
	    return sqlSession.selectList("mypage.selectDonationDetail", param);
	}

}
