package com.example.suhodan.shop.cart;

import java.util.List;

public interface CartDAO {
	List<CartDTO> list(String user_id);
	void insert(CartDTO dto);
	void delete(int cart_id);
	void delete_all(String user_id);
	int sum_money(String user_id);
	void modify(CartDTO dto);
	CartDTO exists(String user_id, int reward_id);
	void addAmount(CartDTO dto);
}