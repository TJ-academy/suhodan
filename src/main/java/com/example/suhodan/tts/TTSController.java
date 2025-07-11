package com.example.suhodan.tts;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TTSController {

	@Autowired
	private TextToSpeechService textToSpeechService;

	@GetMapping("/admin/legend/tts_form.do")
	public String tts_form() {
		return "/admin/legend/tts_form";
	}

	@PostMapping("/admin/legend/generate_speech.do")
	public String generateSpeech(@RequestParam("text") String text,

			@RequestParam("filename") String filename, HttpServletRequest request) {
		try {
			String path = request.getServletContext().getRealPath("/resources/output_tts/");
			textToSpeechService.generateSpeech(text, filename, path);
			return "redirect:/admin/legend_list.do";
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}
	}
}
