package com.example.suhodan.reward;

import java.util.List;
import java.util.Map;

import com.example.suhodan.legend.LegendDTO;

public interface RewardDAO {
	List<RewardDTO> list();
	List<RewardDTO> listPaging(Map<String, Integer> param);
	int getTotalCount();
	void insert(RewardDTO dto);
	String img_file_info(int reward_id);
}
