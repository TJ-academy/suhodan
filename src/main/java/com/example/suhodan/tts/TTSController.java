package com.example.suhodan.tts;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class TTSController {

    @Autowired
    private TextToSpeechService textToSpeechService;

    @GetMapping("/admin/tts_form.do")
    public String tts_form() {
        return "/admin/legend/tts_form";
    }
    
    @PostMapping("/admin/generate_speech.do")
    public String generateSpeech(@RequestParam("text") String text,
                                 @RequestParam("filename") String filename,
                                 HttpServletRequest request) {
        try {
            // 파일 경로: /resources/tts/ 디렉토리에 저장
            String path = request.getServletContext().getRealPath("/resources/output_tts/");
            textToSpeechService.generateSpeech(text, filename, path);
            return "redirect:/admin/legend_list.do";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }
}
