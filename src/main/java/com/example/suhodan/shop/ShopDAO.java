package com.example.suhodan.shop;

import java.util.List;

public interface ShopDAO {
	List<ShopDTO> list();
	ShopDTO detail(int reward_id);
	void update(ShopDTO dto);
	void delete(int reward_id);
	void insert(ShopDTO dto);
}
