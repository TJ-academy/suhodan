package com.example.suhodan.legend;

import java.util.List;

public interface LegendDAO {
	List<LegendDTO> list();
	LegendDTO detail(int legend_id);
	List<LegendDTO> list_location(String location);
	void insert(LegendDTO dto);
	void update(LegendDTO dto);
	void delete(int legend_id);
}
