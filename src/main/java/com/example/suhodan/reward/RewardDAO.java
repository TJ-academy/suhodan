package com.example.suhodan.reward;

import java.util.List;
import java.util.Map;

public interface RewardDAO {
	List<RewardDTO> list();
	List<RewardDTO> listPaging(Map<String, Integer> param);
	int getTotalCount();
	void insert(RewardDTO dto);
	String img_file_info(int reward_id);
	void update(RewardDTO dto);
	void delete(int reward_id);
	int getTotalCountSearch(Map<String, Object> param);
	List<RewardDTO> listPagingSearch(Map<String, Object> param);
	RewardDTO getRewardDetailsById(int reward_id);
	
	String getRewardName(int reward_id);
	int getRewardId(String name);
}

