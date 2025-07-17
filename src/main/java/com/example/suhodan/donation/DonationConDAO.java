package com.example.suhodan.donation;

import java.util.List;
import java.util.Map;

import com.example.suhodan.reward.RewardDTO;

public interface DonationConDAO {
	List<DonationConDTO> list();
	
	DonationConDTO detail(int content_id);
	
	void update(DonationConDTO dto);
	
	void delete(int content_id);
	
	void insert(DonationConDTO dto);
	
	String file_info(int content_id);
	
	int getCount(); //전체 게시물 수 조회(페이지네이션 계산용)
	
	List<DonationConDTO> listPaging(Map<String, Object> paramMap);
	
	void insertTransaction(DonationTransactionDTO dto); //결제처리
	
	int getTotalCountSearch(Map<String, Object> param);
	
	List<DonationConDTO> listPagingSearch(Map<String, Object> param);
	
	int getRewardAByContentId(int content_id);
	int getRewardBByContentId(int content_id);
	int getRewardCByContentId(int content_id);
	int getRewardDByContentId(int content_id);

}
