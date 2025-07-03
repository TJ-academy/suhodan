package com.example.suhodan.suhomap;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

public interface SuhoMapDAO {
	List<SuhoMapDTO> list_all();
	
	List<SuhoMapDTO> detail_sido(String sido);
	
	List<SuhoMapDTO> detail_class(String danger_class);
}
