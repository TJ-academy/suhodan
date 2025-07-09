package com.example.suhodan.donation;

import java.io.File;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.util.PageInfo;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/donation/*")
public class DonationConController {
	@Autowired
	DonationConDAO donationConDao;
	
	@GetMapping("write.do")
	public String write() {
		return "donation/donationCon_write";
	}
	
	@RequestMapping("insert.do")
	public String insert(DonationConDTO dto, HttpServletRequest request) {
		String filename = "-";
		if(!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/donation_img/");
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		dto.setFilename(filename);
		donationConDao.insert(dto);
		return "redirect:/donation/list.do";
	}
	
	@GetMapping("list.do")
	public ModelAndView list(
	    @RequestParam(value = "curPage", required = false, defaultValue = "1") int curPage,
	    ModelAndView mav
	) {
	    int pageSize = 8; // ✅ 한 페이지에 보여줄 개수
	    int totalCount = donationConDao.getCount(); // ✅ 전체 글 수 (DAO에 메서드 추가 필요)

	    // ✅ 페이지 계산 유틸
	    PageInfo pageInfo = new PageInfo(totalCount, curPage, pageSize);

	    // ✅ 범위만큼 데이터 조회 (DAO에 start/end 넘기는 메서드 필요)
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("start", pageInfo.getStartIndex());
	    paramMap.put("end", pageInfo.getEndIndex());
	    List<DonationConDTO> list = donationConDao.listPaging(paramMap);

	    // ✅ View 및 데이터 전달
	    mav.setViewName("/donation/con_list");
	    mav.addObject("list", list);
	    mav.addObject("map", Map.of("page_info", pageInfo)); // JSP에서 ${map.page_info.xxx}로 사용
	    return mav;
	}

	
//	@GetMapping("list.do")
//	public ModelAndView list(ModelAndView mav) {
//		mav.setViewName("/donation/con_list");
//		mav.addObject("list", donationConDao.list());
//		return mav;
//	}
	
	@GetMapping("edit/{content_id}")
	public ModelAndView edit(@PathVariable(name = "content_id") int content_id, ModelAndView mav) {
		mav.setViewName("/donation/con_edit");
		mav.addObject("dto", donationConDao.detail(content_id));
		return mav;
	}
	
	@PostMapping("update.do")
	public String update(DonationConDTO dto, HttpServletRequest request) {
		String filename = "-";
		if(!dto.getFile1().isEmpty()) {
			filename = dto.getFile1().getOriginalFilename();
			try {
				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/donation_img/");
				new File(path).mkdir();
				dto.getFile1().transferTo(new File(path + filename));
			} catch (Exception e) {
				e.printStackTrace();
			}
			dto.setFilename(filename);
		} else {
			DonationConDTO dto2 = donationConDao.detail(dto.getContent_id());
			dto.setFilename(dto2.getFilename());
		}
		donationConDao.update(dto);
		return "redirect:/donation/list.do";
	}
	
	@PostMapping("delete.do")
	public String delete(@RequestParam(name = "content_id") int content_id, HttpServletRequest request) {
		String filename = donationConDao.file_info(content_id);
		if(filename != null && !filename.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/resources/donation_img/");
			File f = new File(path + filename);
			if(f.exists())
				f.delete();
		}
		donationConDao.delete(content_id);
		return "redirect:/donation/list.do";
	}
	
	@GetMapping("detail/{content_id}")
	public ModelAndView detail(@PathVariable(name="content_id") int content_id, ModelAndView mav) {
		mav.setViewName("/donation/donation_detail");
		mav.addObject("dto", donationConDao.detail(content_id));
		return mav;
	}
}
