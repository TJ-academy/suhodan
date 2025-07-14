package com.example.suhodan.goods;

import java.util.List;
import java.util.Map;

public interface GoodsDAO {
	List<GoodsDTO> list();
	List<GoodsDTO> listPaging(Map<String, Integer> param);
	int getTotalCount();
	void insert(GoodsDTO dto);
	void update(GoodsDTO dto);
	void delete(int goods_id);
	String img_file_info(int goods_id);
	String detail_img_file_info(int goods_id);
	int getTotalCountSearch(Map<String, Object> param);
	List<GoodsDTO> listPagingSearch(Map<String, Object> param);
	String getGoodsName(int goods_id);
}
