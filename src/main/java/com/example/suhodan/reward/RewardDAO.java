package com.example.suhodan.reward;

import java.util.List;

public interface RewardDAO {
	List<RewardDTO> list();
	void insert(RewardDTO dto);
}
