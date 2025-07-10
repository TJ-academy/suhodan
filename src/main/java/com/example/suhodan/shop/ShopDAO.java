package com.example.suhodan.shop;

import java.util.List;

public interface ShopDAO {
	List<ShopDTO> list();
	ShopDTO detail(int goods_id);
}
