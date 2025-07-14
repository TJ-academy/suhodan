package com.example.suhodan.badge;

import java.util.List;
import java.util.Map;

public interface BadgeDAO {
	List<BadgeDTO> list();
	List<BadgeDTO> listPaging(Map<String, Integer> param);
	int getTotalCount();
	void insert(BadgeDTO dto);
	void update(BadgeDTO dto);
	void delete(int badge_id);
	String img_file_info(int badge_id);
	int getTotalCountSearch(Map<String, Object> param);
	List<BadgeDTO> listPagingSearch(Map<String, Object> param);
}