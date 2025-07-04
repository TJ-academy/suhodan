package com.example.suhodan.admin;

import java.io.File;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.badge.BadgeDAO;
import com.example.suhodan.legend.LegendDAO;
import com.example.suhodan.legend.LegendDTO;
import com.example.suhodan.member.MemberDAO;
import com.example.suhodan.reward.RewardDAO;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	@Autowired
	MemberDAO memberDao;
	@Autowired
	LegendDAO legendDao;
	@Autowired
	RewardDAO rewardDao;
	@Autowired
	BadgeDAO badgeDao;
	
	@GetMapping("member_list.do")
	public ModelAndView member_list(ModelAndView mav) {
		mav.setViewName("/admin/member_list");
		mav.addObject("list", memberDao.list());
		return mav;
	}
	
	@GetMapping("legend_list.do")
	public ModelAndView legend_list(ModelAndView mav) {
		mav.setViewName("/admin/legend_list");
		mav.addObject("list", legendDao.list());
		return mav;
	}
	
	//설화추가 페이지 이동 - 테스트(삭제예정)
	@GetMapping("/legend_reg")
	public String home() {
		return "/admin/legend_reg";
	}

	@PostMapping("legend_insert.do")
	public String legend_insert(LegendDTO dto, HttpServletRequest request) {
		
		String imgFileName = "";
		String ttsAudioFileName = "";
		
		try {
	        // 첫 번째 파일 처리
	        if (!dto.getImg().isEmpty()) {
	        	imgFileName = dto.getImg().getOriginalFilename();
	        	ServletContext application = request.getSession().getServletContext();
		        String path1 = application.getRealPath("/resources/legend_img/");
		        dto.getImg().transferTo(new File(path1 + imgFileName));
	        }

	        // 두 번째 파일 처리
	        if (!dto.getTts_audio().isEmpty()) {
	        	ttsAudioFileName = dto.getTts_audio().getOriginalFilename();
	            ServletContext application = request.getSession().getServletContext();
	            String path2 = application.getRealPath("/resources/legend_tts/");
	            dto.getTts_audio().transferTo(new File(path2 + ttsAudioFileName));
	        }

	        // 파일명 설정 (둘 다 저장되면 DTO에 파일명 추가)
	        dto.setImgFileName(imgFileName);
	        dto.setTtsAudioFileName(ttsAudioFileName);

	        // 데이터베이스에 저장
	        legendDao.insert(dto);

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";  // 예외 처리
	    }
		return "redirect:/admin/legend_list.do";
	}
	
	@PostMapping("legend_update.do")
	public String legend_update(LegendDTO dto, HttpServletRequest request) {
        String imgFileName = "";
        String ttsAudioFileName = "";

        try {
            // 첫 번째 파일 처리: 이미지 파일 업로드
            if (!dto.getImg().isEmpty()) {
                imgFileName = dto.getImg().getOriginalFilename();
                ServletContext application = request.getSession().getServletContext();
                String path1 = application.getRealPath("/resources/legend_img/");
                dto.getImg().transferTo(new File(path1 + imgFileName));
            }

            // 두 번째 파일 처리: TTS 오디오 파일 업로드
            if (!dto.getTts_audio().isEmpty()) {
                ttsAudioFileName = dto.getTts_audio().getOriginalFilename();
                ServletContext application = request.getSession().getServletContext();
                String path2 = application.getRealPath("/resources/legend_tts/");
                dto.getTts_audio().transferTo(new File(path2 + ttsAudioFileName));
            }

            // 파일명 설정 (둘 다 저장되면 DTO에 파일명 추가)
            dto.setImgFileName(imgFileName);
            dto.setTtsAudioFileName(ttsAudioFileName);

            // 데이터베이스에서 수정
            legendDao.update(dto);

        } catch (Exception e) {
            e.printStackTrace();
            return "error";  // 예외 처리
        }
		
		return "redirect:/admin/legend_list.do";
	}
	
	@GetMapping("legend_delete.do")
	public String legend_delete(@RequestParam(name = "legend_id") int legend_id) {
		
		/*
		 * 수정시 파일 데이터도 같이 삭제되게끔!
		 */
		legendDao.delete(legend_id);
		return "redirect:/admin/legend_list.do";
	}
	
	@GetMapping("reward_list.do")
	public ModelAndView reward_list(ModelAndView mav) {
		mav.setViewName("/admin/reward_list");
		mav.addObject("list", rewardDao.list());
		return mav;
	}
	
	@GetMapping("badge_list.do")
	public ModelAndView badge_list(ModelAndView mav) {
		mav.setViewName("/admin/badge_list");
		mav.addObject("list", badgeDao.list());
		return mav;
	}
}
