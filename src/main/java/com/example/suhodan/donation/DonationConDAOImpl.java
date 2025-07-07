package com.example.suhodan.donation;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DonationConDAOImpl implements DonationConDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<DonationConDTO> list() {
		return sqlSession.selectList("donationCon.list");
	}

	@Override
	public DonationConDTO detail(int content_id) {
		return sqlSession.selectOne("donationCon.detail", content_id);
	}

	@Override
	public void update(DonationConDTO dto) {
		sqlSession.update("donationCon.update", dto);
	}

	@Override
	public void delete(int content_id) {
		sqlSession.delete("donationCon.delete", content_id);
	}

	@Override
	public void insert(DonationConDTO dto) {
		sqlSession.insert("donationCon.insert", dto);
	}

	@Override
	public String file_info(int content_id) {
		return sqlSession.selectOne("donationCon.file_info", content_id);
	}

}
