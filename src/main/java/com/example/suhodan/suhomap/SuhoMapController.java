package com.example.suhodan.suhomap;

import com.example.suhodan.suhomap.SuhoMapDTO;
import com.example.suhodan.suhomap.SuhoMapDAO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class SuhoMapController {
	
	@Autowired
	private SuhoMapDAO suhoMapDao;
	
	@GetMapping("/map")
	public String showMap(Model model) throws JsonProcessingException {
		List<SuhoMapDTO> list = suhoMapDao.list_all(); //DB에서 전체 데이터조회
		
		//리스트를 JSON 문자열로 반환
		ObjectMapper mapper = new ObjectMapper();
		String jsonData = mapper.writeValueAsString(list);
		
		model.addAttribute("suhoListJson", jsonData);
		
		return "map";
	}
}
