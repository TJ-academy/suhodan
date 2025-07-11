package com.example.suhodan.admin;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.example.suhodan.badge.BadgeDAO;
import com.example.suhodan.badge.BadgeDTO;
import com.example.suhodan.donation.DonationConDAO;
import com.example.suhodan.donation.DonationConDTO;
import com.example.suhodan.donation.DonationListDTO;
import com.example.suhodan.donation.DonationTransactionDAO;
import com.example.suhodan.goods.GoodsDAO;
import com.example.suhodan.goods.GoodsDTO;
import com.example.suhodan.legend.LegendDAO;
import com.example.suhodan.legend.LegendDTO;
import com.example.suhodan.member.MemberDAO;
import com.example.suhodan.member.MemberDTO;
import com.example.suhodan.reward.RewardDAO;
import com.example.suhodan.reward.RewardDTO;
import com.example.suhodan.util.PageUtil;

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
	@Autowired
	GoodsDAO goodsDao;
	@Autowired
	DonationConDAO donationConDao;
	@Autowired
	DonationTransactionDAO donationTADao;

	@GetMapping("/")
	public String home() {
		return "/admin/admin_index";
	}

	@GetMapping("member_list.do")
	public ModelAndView member_list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "searchType", required = false) String searchType,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(value = "sortBy", defaultValue = "join_date") String sortBy,
			@RequestParam(value = "sortOrder", defaultValue = "asc") String sortOrder, ModelAndView mav) {

		// 검색과 정렬 조건을 param에 담기
		Map<String, Object> param = new HashMap<>();
		param.put("searchType", searchType);
		param.put("searchKeyword", searchKeyword);
		param.put("sortBy", sortBy);
		param.put("sortOrder", sortOrder);

		// 총 레코드 수 가져오기
		int totalCount = memberDao.getTotalCount(param);
		PageUtil pu = new PageUtil(page, totalCount);

		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());

		List<MemberDTO> list = memberDao.listPaging(param);

		mav.setViewName("/admin/member/member_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		mav.addObject("searchType", searchType);
		mav.addObject("searchKeyword", searchKeyword);
		mav.addObject("sortBy", sortBy);
		mav.addObject("sortOrder", sortOrder);
		return mav;
	}

	@GetMapping("legend_list.do")
	public ModelAndView legend_list(@RequestParam(value = "page", defaultValue = "1") int page, ModelAndView mav) {
		int totalCount = legendDao.getTotalCount();
		PageUtil pu = new PageUtil(page, totalCount);

		Map<String, Integer> param = new HashMap<>();
		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());

		List<LegendDTO> list = legendDao.listPaging(param);

		mav.setViewName("/admin/legend/legend_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		return mav;
	}

	@PostMapping("legend_insert.do")
	public String legend_insert(LegendDTO dto, HttpServletRequest request) {

		String img = "";
		String tts_audio = "";

		try {
			// 첫 번째 파일 처리
			if (!dto.getImgFile().isEmpty()) {
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path1 = application.getRealPath("/resources/legend_img/");
				dto.getImgFile().transferTo(new File(path1 + img));
			}

			// 두 번째 파일 처리
			if (!dto.getTtsAudioFile().isEmpty()) {
				String originalTtsAudioName = dto.getTtsAudioFile().getOriginalFilename();
				String ttsAudioUUID = UUID.randomUUID().toString(); // UUID 생성
				String ttsAudioExtension = originalTtsAudioName.substring(originalTtsAudioName.lastIndexOf("."));
				tts_audio = ttsAudioUUID + ttsAudioExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path2 = application.getRealPath("/resources/legend_tts/");
				dto.getTtsAudioFile().transferTo(new File(path2 + tts_audio));
			}

			// 파일명 설정 (둘 다 저장되면 DTO에 파일명 추가)
			dto.setImg(img);
			dto.setTts_audio(tts_audio);

			// 데이터베이스에 저장
			legendDao.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/legend_list.do";
	}

	@PostMapping("legend_update.do")
	public String legend_update(LegendDTO dto, HttpServletRequest request) {
		String img = "";
		String tts_audio = "";

		try {
			// 기존 이미지 파일명을 받는다.
			String currentImg = legendDao.img_file_info(dto.getLegend_id());
			String currentTts = legendDao.tts_file_info(dto.getLegend_id());

			if (!dto.getImgFile().isEmpty()) {
				// 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path1 = application.getRealPath("/resources/legend_img/");
				dto.getImgFile().transferTo(new File(path1 + img));
			} else {
				// 새 이미지가 없으면 기존 이미지를 유지한다.
				img = currentImg;
			}

			if (!dto.getTtsAudioFile().isEmpty()) {
				// 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				String originalTtsAudioName = dto.getTtsAudioFile().getOriginalFilename();
				String ttsAudioUUID = UUID.randomUUID().toString(); // UUID 생성
				String ttsAudioExtension = originalTtsAudioName.substring(originalTtsAudioName.lastIndexOf("."));
				tts_audio = ttsAudioUUID + ttsAudioExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path2 = application.getRealPath("/resources/legend_tts/");
				dto.getTtsAudioFile().transferTo(new File(path2 + tts_audio));
			} else {
				// 새 이미지가 없으면 기존 이미지를 유지한다.
				tts_audio = currentTts;
			}

			dto.setImg(img);
			dto.setTts_audio(tts_audio);

			legendDao.update(dto);

		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}

		return "redirect:/admin/legend_list.do";
	}

	@GetMapping("legend_delete.do")
	public String legend_delete(@RequestParam(name = "legend_id") int legend_id, HttpServletRequest request) {
		String img = legendDao.img_file_info(legend_id);
		String tts_audio = legendDao.tts_file_info(legend_id);
		if (img != null && !img.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path1 = application.getRealPath("/resources/legend_img/");
			File f = new File(path1 + img);
			if (f.exists())
				f.delete();
		}
		if (tts_audio != null && !tts_audio.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path2 = application.getRealPath("/resources/legend_tts/");
			File f = new File(path2 + tts_audio);
			if (f.exists())
				f.delete();
		}
		legendDao.delete(legend_id);
		return "redirect:/admin/legend_list.do";
	}

	@GetMapping("reward_list.do")
	public ModelAndView reward_list(@RequestParam(value = "page", defaultValue = "1") int page, ModelAndView mav) {
		int totalCount = rewardDao.getTotalCount();
		PageUtil pu = new PageUtil(page, totalCount);

		Map<String, Integer> param = new HashMap<>();
		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());

		List<RewardDTO> list = rewardDao.listPaging(param);
		mav.setViewName("/admin/reward/reward_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		return mav;
	}

	@PostMapping("reward_insert.do")
	public String reward_insert(RewardDTO dto, HttpServletRequest request) {

		String img = "";

		try {
			if (!dto.getImgFile().isEmpty()) {
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/reward_img/");
				dto.getImgFile().transferTo(new File(path + img));
			}
			dto.setImg(img);
			rewardDao.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "redirect:/admin/reward_list.do";
	}

	@PostMapping("reward_update.do")
	public String reward_update(RewardDTO dto, HttpServletRequest request) {
		String img = "";

		try {
			String currentImg = rewardDao.img_file_info(dto.getReward_id());

			if (!dto.getImgFile().isEmpty()) { // 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				if (currentImg != null && !currentImg.equals("-")) {
					// 기존 이미지 삭제
					ServletContext application = request.getSession().getServletContext();
					String path = application.getRealPath("/resources/reward_img/");
					File oldFile = new File(path + currentImg);
					if (oldFile.exists()) {
						oldFile.delete(); // 기존 파일 삭제
					}
				}
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path1 = application.getRealPath("/resources/reward_img/");
				dto.getImgFile().transferTo(new File(path1 + img));

			} else {
				img = currentImg;
			}

			dto.setImg(img);

			rewardDao.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error";
		}

		return "redirect:/admin/reward_list.do";
	}

	@GetMapping("reward_delete.do")
	public String reward_delete(@RequestParam(name = "reward_id") int reward_id, HttpServletRequest request) {
		String img = goodsDao.img_file_info(reward_id);
		if (img != null && !img.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/resources/reward_img/");
			File f = new File(path + img);
			if (f.exists())
				f.delete();
		}
		rewardDao.delete(reward_id);
		return "redirect:/admin/reward_list.do";
	}

	@GetMapping("goods_list.do")
	public ModelAndView goods_list(@RequestParam(value = "page", defaultValue = "1") int page, ModelAndView mav) {
		int totalCount = goodsDao.getTotalCount();
		PageUtil pu = new PageUtil(page, totalCount);

		Map<String, Integer> param = new HashMap<>();
		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());

		List<GoodsDTO> list = goodsDao.listPaging(param);

		mav.setViewName("/admin/goods/goods_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		return mav;
	}

	@PostMapping("goods_insert.do")
	public String goods_insert(GoodsDTO dto, HttpServletRequest request) {

		String img = "";
		String detail_img = "";

		try {
			if (!dto.getImgFile().isEmpty()) {
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path1 = application.getRealPath("/resources/goods_img/");
				dto.getImgFile().transferTo(new File(path1 + img));
			}
			if (!dto.getDetailImgFile().isEmpty()) {
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				detail_img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path2 = application.getRealPath("/resources/goods_detail_img/");
				dto.getDetailImgFile().transferTo(new File(path2 + detail_img));
			}
			dto.setImg(img);
			dto.setDetail_img(detail_img);
			goodsDao.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/goods_list.do";
	}

	@PostMapping("goods_update.do")
	public String goods_update(GoodsDTO dto, HttpServletRequest request) {
		String img = "";
		String detail_img = "";
		try {
			// 기존 이미지 파일명을 받는다.
			String currentImg = goodsDao.img_file_info(dto.getGoods_id());
			String currentDetailImg = goodsDao.detail_img_file_info(dto.getGoods_id());

			// 상품 이미지 처리
			if (!dto.getImgFile().isEmpty()) {
				// 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path1 = application.getRealPath("/resources/goods_img/");
				dto.getImgFile().transferTo(new File(path1 + img));

				// 기존 이미지 삭제
				if (currentImg != null && !currentImg.equals("-")) {
					File oldFile = new File(path1 + currentImg);
					if (oldFile.exists()) {
						oldFile.delete(); // 기존 이미지 삭제
					}
				}
			} else {
				// 새 이미지가 없으면 기존 이미지를 유지한다.
				img = currentImg;
			}

			// 상세 이미지 처리
			if (!dto.getDetailImgFile().isEmpty()) {
				// 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				String originalDetailImgName = dto.getDetailImgFile().getOriginalFilename();
				String detailImgUUID = UUID.randomUUID().toString(); // UUID 생성
				String detailImgExtension = originalDetailImgName.substring(originalDetailImgName.lastIndexOf("."));
				detail_img = detailImgUUID + detailImgExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path2 = application.getRealPath("/resources/goods_detail_img/");
				dto.getDetailImgFile().transferTo(new File(path2 + detail_img));

				// 기존 상세 이미지 삭제
				if (currentDetailImg != null && !currentDetailImg.equals("-")) {
					File oldDetailFile = new File(path2 + currentDetailImg);
					if (oldDetailFile.exists()) {
						oldDetailFile.delete(); // 기존 상세 이미지 삭제
					}
				}
			} else {
				// 새 이미지가 없으면 기존 이미지를 유지한다.
				detail_img = currentDetailImg;
			}

			// 파일명 설정
			dto.setImg(img);
			dto.setDetail_img(detail_img);

			// DB 업데이트
			goodsDao.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/goods_list.do";
	}

	@GetMapping("goods_delete.do")
	public String goods_delete(@RequestParam(name = "goods_id") int goods_id, HttpServletRequest request) {
		String img = goodsDao.img_file_info(goods_id);
		String detail_img = goodsDao.detail_img_file_info(goods_id);
		if (img != null && !img.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path1 = application.getRealPath("/resources/goods_img/");
			File f = new File(path1 + img);
			if (f.exists())
				f.delete();
		}
		if (detail_img != null && !detail_img.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path2 = application.getRealPath("/resources/goods_detail_img/");
			File f = new File(path2 + detail_img);
			if (f.exists())
				f.delete();
		}
		goodsDao.delete(goods_id);
		return "redirect:/admin/goods_list.do";
	}

	@GetMapping("badge_list.do")
	public ModelAndView badge_list(@RequestParam(value = "page", defaultValue = "1") int page, ModelAndView mav) {
		int totalCount = badgeDao.getTotalCount();
		PageUtil pu = new PageUtil(page, totalCount);

		Map<String, Integer> param = new HashMap<>();
		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());

		List<BadgeDTO> list = badgeDao.listPaging(param);

		mav.setViewName("/admin/badge/badge_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		return mav;
	}

	@PostMapping("badge_insert.do")
	public String badge_insert(BadgeDTO dto, HttpServletRequest request) {
		String img = "";
		try {
			if (!dto.getImgFile().isEmpty()) {
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/badge_img/");
				dto.getImgFile().transferTo(new File(path + img));
			}
			dto.setImg(img);
			badgeDao.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/badge_list.do";
	}

	@PostMapping("badge_update.do")
	public String badge_update(BadgeDTO dto, HttpServletRequest request) {
		String img = "";
		try {
			// 기존 이미지 파일명을 받는다.
			String currentImg = badgeDao.img_file_info(dto.getBadge_id());

			if (!dto.getImgFile().isEmpty()) {
				if (currentImg != null && !currentImg.equals("-")) {
					// 기존 이미지 삭제
					ServletContext application = request.getSession().getServletContext();
					String path = application.getRealPath("/resources/badge_img/");
					File oldFile = new File(path + currentImg);
					if (oldFile.exists()) {
						oldFile.delete(); // 기존 파일 삭제
					}
				}
				// 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				String originalImgName = dto.getImgFile().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				img = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/badge_img/");
				dto.getImgFile().transferTo(new File(path + img));
			} else {
				// 새 이미지가 없으면 기존 이미지를 유지한다.
				img = currentImg;
			}
			dto.setImg(img);
			badgeDao.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/badge_list.do";
	}

	@GetMapping("badge_delete.do")
	public String badge_delete(@RequestParam(name = "badge_id") int badge_id, HttpServletRequest request) {
		String img = badgeDao.img_file_info(badge_id);
		if (img != null && !img.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/resources/badge_img/");
			File f = new File(path + img);
			if (f.exists())
				f.delete();
		}
		badgeDao.delete(badge_id);
		return "redirect:/admin/badge_list.do";
	}

	@GetMapping("donation_contents_list.do")
	public ModelAndView donation_contents_list(@RequestParam(value = "page", defaultValue = "1") int page,
			ModelAndView mav) {
		int totalCount = donationConDao.getCount();
		PageUtil pu = new PageUtil(page, totalCount);

		Map<String, Object> param = new HashMap<>();
		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());

		List<DonationConDTO> list = donationConDao.listPaging(param);

		mav.setViewName("/admin/donation/donation_contents_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		return mav;
	}

	@PostMapping("donation_contents_insert.do")
	public String donation_contents_insert(DonationConDTO dto, HttpServletRequest request) {
		String filename = "";
		try {
			if (!dto.getFile1().isEmpty()) {
				String originalImgName = dto.getFile1().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				filename = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/donation_img/");
				dto.getFile1().transferTo(new File(path + filename));
			}
			dto.setFilename(filename);
			donationConDao.insert(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/donation_contents_list.do";
	}

	@PostMapping("donation_contents_update.do")
	public String donation_contents_update(DonationConDTO dto, HttpServletRequest request) {
		String filename = "";
		try {
			// 기존 이미지 파일명을 받는다.
			String currentImg = donationConDao.file_info(dto.getContent_id());

			if (!dto.getFile1().isEmpty()) {
				if (currentImg != null && !currentImg.equals("-")) {
					// 기존 이미지 삭제
					ServletContext application = request.getSession().getServletContext();
					String path = application.getRealPath("/resources/donation_img/");
					File oldFile = new File(path + currentImg);
					if (oldFile.exists()) {
						oldFile.delete(); // 기존 파일 삭제
					}
				}

				// 새 이미지가 업로드되면 기존 파일명을 덮어씌운다.
				String originalImgName = dto.getFile1().getOriginalFilename();
				String imgUUID = UUID.randomUUID().toString(); // UUID 생성
				String fileExtension = originalImgName.substring(originalImgName.lastIndexOf("."));
				filename = imgUUID + fileExtension; // UUID를 붙인 파일명

				ServletContext application = request.getSession().getServletContext();
				String path = application.getRealPath("/resources/donation_img/");
				dto.getFile1().transferTo(new File(path + filename));
			} else {
				// 새 이미지가 없으면 기존 이미지를 유지한다.
				filename = currentImg;
			}
			dto.setFilename(filename);
			donationConDao.update(dto);
		} catch (Exception e) {
			e.printStackTrace();
			return "error"; // 예외 처리
		}
		return "redirect:/admin/donation_contents_list.do";
	}

	@GetMapping("donation_contents_delete.do")
	public String donation_contents_delete(@RequestParam(name = "content_id") int content_id,
			HttpServletRequest request) {
		String filename = donationConDao.file_info(content_id);
		if (filename != null && !filename.equals("-")) {
			ServletContext application = request.getSession().getServletContext();
			String path = application.getRealPath("/resources/donation_img/");
			File f = new File(path + filename);
			if (f.exists())
				f.delete();
		}
		donationConDao.delete(content_id);
		return "redirect:/admin/donation_contetns_list.do";
	}

	@GetMapping("donation_list.do")
	public ModelAndView donation_list(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "search_option", defaultValue = "") String searchOption, // 검색 옵션
			@RequestParam(value = "keyword", defaultValue = "") String keyword, // 검색 키워드
			ModelAndView mav) {

		System.out.println("donation_list.do 요청 처리 시작");

		// 검색 조건을 추가한 전체 레코드 개수 계산
		int totalCount = donationTADao.getTotalCount(searchOption, keyword); // getTotalCount 메서드를 수정해서 검색된 레코드 개수를
																				// 반환하도록 수정
		System.out.println("총 개수: " + totalCount);
		PageUtil pu = new PageUtil(page, totalCount);

		Map<String, Object> param = new HashMap<>();
		param.put("start", pu.getStart());
		param.put("end", pu.getEnd());
		param.put("search_option", searchOption); // 검색 옵션
		param.put("keyword", keyword); // 검색 키워드

		// 리스트 조회
		List<DonationListDTO> list = donationTADao.listPagingSearch(param);
		System.out.println("조회된 리스트 크기: " + list.size());

		mav.setViewName("/admin/donation/donation_list");
		mav.addObject("list", list);
		mav.addObject("currentPage", pu.getCurrentPage());
		mav.addObject("totalPage", pu.getTotalPage());
		mav.addObject("searchOption", searchOption); // 현재 검색 옵션을 JSP로 전달
		mav.addObject("keyword", keyword); // 현재 검색 키워드를 JSP로 전달

		return mav;
	}
}
