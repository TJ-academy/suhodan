package com.example.suhodan.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class MemberController {
	@Autowired
	MemberDAO memberDao;

	// 로그인 페이지 이동
	@GetMapping("login.do")
	public String login() {
		return "member/login";
	}

	// 로그인 처리
	@PostMapping("login_check.do")
	public ModelAndView login_check(MemberDTO dto, HttpSession session) {
		String name = memberDao.login(dto);
		ModelAndView mav = new ModelAndView();

		if (name != null) {
			session.setAttribute("user_id", dto.getUser_id());
			session.setAttribute("name", name);

			if ("admin".equals(dto.getUser_id())) {
				mav.setViewName("redirect:/admin/");
			} else {
				mav.setViewName("index");
			}
			
		} else {
			mav.setViewName("member/login");
			mav.addObject("message", "error");
		}
		return mav;
	}

	// 로그아웃
	@GetMapping("/logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		session.invalidate();
		mav.setViewName("member/login");
		mav.addObject("message", "logout");
		return mav;
	}

	// 회원가입 페이지 이동
	@GetMapping("join.do")
	public String join() {
		return "member/join";
	}

	// join_next 페이지 이동
	@RequestMapping("join_next.do")
	public String join_next() {
		return "member/join_next";
	}

	// 아이디 중복체크
	@GetMapping("/check_id.do")
	@ResponseBody
	public String checkId(@RequestParam("user_id") String user_id) {
		boolean exists = memberDao.isUserIdExists(user_id);
		return exists ? "DUPLICATE" : "OK";
	}

	// 회원가입 처리
	@PostMapping("/insert.do")
	public String insert(@ModelAttribute MemberDTO dto) {
		System.out.println(dto);
		memberDao.insert(dto);
		return "member/join_finish";
	}

	// 마이페이지로 이동
	@GetMapping("/mypage")
	public String view(HttpSession session, Model model) {
		String userid = (String) session.getAttribute("user_id");
		if (userid == null) {
			return "redirect:/login.do?message=nologin";
		}
		return "member/mypage/mypage";
	}

	// 회원정보 수정페이지로 이동
	@GetMapping("/mypage/edit")
	public String detail(HttpSession session, Model model) {
		String userid = (String) session.getAttribute("user_id");

		MemberDTO dto = memberDao.detail(userid);
		model.addAttribute("dto", dto);

		System.out.println("\n\n" + model + "\n\n");
		return "/member/mypage/mypage_update";
	}

	// 회원정보 수정사항 저장하기
	@PostMapping("/mypage/update.do")
	public String update(@ModelAttribute MemberDTO dto, Model model) {
		boolean result = memberDao.check_passwd(dto.getUser_id(), dto.getPasswd());
		if (result) { // 비밀번호가 맞으면 true(1), 틀리면 false(0)
			memberDao.update(dto);
			return "member/mypage/mypage";
		} else { // 비밀번호가 틀릴경우
			/*
			 * MemberDTO dto2 = memberDao.detail(dto.getUser_id());
			 * dto.setJoin_date(dto2.getJoin_date());
			 */
			model.addAttribute("dto", dto);
			model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
			return "member/mypage/mypage_update";
		}
	}

	@PostMapping("/mypage/delete.do")
	public String delete(@RequestParam(name = "user_id") String user_id, @RequestParam(name = "passwd") String passwd,
			HttpSession session, Model model) {
		boolean result = memberDao.check_passwd(user_id, passwd);
		if (result) {
			session.invalidate();
			memberDao.delete(user_id);
			return "redirect:/";
		} else {
			model.addAttribute("message", "비밀번호가 일치하지 않습니다.");
			model.addAttribute("dto", memberDao.detail(user_id));
			return "member/mypage/mypage_update";
		}
	}
}
