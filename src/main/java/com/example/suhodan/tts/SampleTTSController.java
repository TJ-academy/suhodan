package com.example.suhodan.tts;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.suhodan.legend.LegendDAO;
import com.example.suhodan.legend.LegendDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class SampleTTSController {

	@Autowired
	TextToSpeechService textToSpeechService;
	@Autowired
	LegendDAO dao;

	@GetMapping("/admin/legend/sample_tts.do")
	public String sample_tts(HttpServletRequest request) {
		List<LegendDTO>	legends = dao.list();
		try { 
			for (LegendDTO legend : legends) {
		
			String legend_id = Integer.toString(legend.getLegend_id());
			String story = legend.getStory();
			
			String path = request.getServletContext().getRealPath("/resources/sample_tts/");
			textToSpeechService.generateSpeech(story, legend_id, path);
			
			
			}
			return "redirect:/admin/legend_list.do";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
