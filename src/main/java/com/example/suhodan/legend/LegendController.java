package com.example.suhodan.legend;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/legend/*")
public class LegendController {
	@Autowired
	LegendDAO legendDao;
	@Autowired
	SearchDonationDAO sdonationDao;
	
	@GetMapping("legend.do")
	public ModelAndView legend_main(ModelAndView mav, 
			@RequestParam(value = "page", defaultValue="1") int page,
			@RequestParam(value = "search_option", required = false) String searchOption,
			@RequestParam(value = "search_keyword", required = false) String searchKeyword) {
		
		List<LegendDTO> fullList = legendDao.list();
		
		//검색어와 검색 옵션이 있을 경우, 검색된 리스트 가져오기
		if(searchKeyword != null && !searchKeyword.trim().isEmpty() && searchOption != null) {
			fullList = legendDao.searchLegend(searchOption, searchKeyword);
		} else {
			fullList = legendDao.list(); //기본 리스트
		}
		
		int pageSize = 8;
		int totalCount = fullList.size();
	    int totalPage = (int) Math.ceil((double) totalCount / pageSize);
	    if(page < 1) page = 1;
	    if(page > totalPage) page = totalPage;
	    int startIndex = (page - 1) * pageSize;
	    int endIndex = Math.min(startIndex + pageSize, totalCount);
	    List<LegendDTO> pageList = fullList.subList(startIndex, endIndex);

	    //검색어 유지를 위해 검색 옵션과 키워드 다시 뷰에 전송
	    mav.addObject("search_option", searchOption);
	    mav.addObject("search_keyword", searchKeyword);
	    
	    mav.addObject("list", pageList);
	    mav.addObject("currentPage", page);
	    mav.addObject("totalPage", totalPage);
		mav.setViewName("/legend/legendList");
		//mav.addObject("list", legendDao.list());
		return mav;
	}
	
	@GetMapping("detail/{legend_id}")
	public ModelAndView detail(@PathVariable(name = "legend_id") int legend_id, ModelAndView mav) {
		mav.setViewName("/legend/legendDetail");
		mav.addObject("dto", legendDao.detail(legend_id));
		return mav;
	}
	
	@GetMapping("locationli")
	public ModelAndView list_location(@RequestParam("location") String location, ModelAndView mav) {
	    mav.setViewName("/legend/locationLegend");
	    mav.addObject("list", legendDao.list_location(location));
	    mav.addObject("location", location);
	    return mav;
	}
	
	@GetMapping("source.do")
	public ModelAndView legend_source(ModelAndView mav) {
		mav.setViewName("/source/legend_source");
		mav.addObject("list", legendDao.list());
		return mav;
	}
	
	@GetMapping("donationListPopup")
	public ModelAndView getDonationListPopup(@RequestParam("location") String location, ModelAndView mav) {
		List<SearchDonationDTO> donationList = sdonationDao.searchFromLocation(location);
		mav.addObject("donationList", donationList);
		mav.setViewName("/legend/donationListPopup");
		return mav;
	}

}
