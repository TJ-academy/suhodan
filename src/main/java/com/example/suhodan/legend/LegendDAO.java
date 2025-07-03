package com.example.suhodan.legend;

import java.util.List;

public interface LegendDAO {
	List<LegendDTO> list();
	void insert(LegendDTO dto);
	void update(LegendDTO dto);
	void delete(int legend_id);
}
