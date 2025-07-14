package com.example.suhodan.legend;

import java.util.List;
import java.util.Map;

public interface LegendDAO {
	List<LegendDTO> list();
	List<LegendDTO> listPaging(Map<String, Integer> param);
	int getTotalCount();
	LegendDTO detail(int legend_id);
	List<LegendDTO> list_location(String location);
	void insert(LegendDTO dto);
	void update(LegendDTO dto);
	void delete(int legend_id);
	String img_file_info(int legend_id);
	String tts_file_info(int legend_id);
	int getTotalCountSearch(Map<String, Object> param);
	List<LegendDTO> listPagingSearch(Map<String, Object> param);
}
