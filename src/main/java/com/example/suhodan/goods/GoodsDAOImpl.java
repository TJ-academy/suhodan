package com.example.suhodan.goods;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GoodsDAOImpl implements GoodsDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<GoodsDTO> list() {
		return sqlSession.selectList("goods.list");
	}

	@Override
	public List<GoodsDTO> listPaging(Map<String, Integer> param) {
		return sqlSession.selectList("goods.listPaging", param);
	}

	@Override
	public int getTotalCount() {
		return sqlSession.selectOne("goods.getTotalCount");
	}

	@Override
	public void insert(GoodsDTO dto) {
		sqlSession.insert("goods.insert", dto);	
	}
	
	@Override
	public void update(GoodsDTO dto) {
		sqlSession.update("goods.update", dto);
	}

	@Override
	public void delete(int goods_id) {
		sqlSession.delete("goods.delete", goods_id);
	}

	@Override
	public String img_file_info(int goods_id) {
		return sqlSession.selectOne("goods.img_file_info", goods_id);
	}

	@Override
	public String detail_img_file_info(int goods_id) {
		return sqlSession.selectOne("goods.detail_img_file_info", goods_id);
	}
}
