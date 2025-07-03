package com.example.suhodan.badge;

import java.util.List;

public interface BadgeDAO {
	List<BadgeDTO> list();
	void insert(BadgeDTO dto);
}
