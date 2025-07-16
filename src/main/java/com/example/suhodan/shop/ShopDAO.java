package com.example.suhodan.shop;

import java.util.List;

public interface ShopDAO {
	List<ShopDTO> list(int start, int end, String category, String keyword, String sort);
	int getShopCount(String category, String keyword);
	ShopDTO detail(int goods_id);
}
