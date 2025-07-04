package com.example.suhodan.legend;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/legend/*")
public class LegendController {
	@Autowired
	LegendDAO legendDao;
	
	@GetMapping("legend.do")
	public ModelAndView legend_main(ModelAndView mav) {
		mav.setViewName("/legend/legendList");
		mav.addObject("list", legendDao.list());
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

}
