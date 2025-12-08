package com.spring.springGroupS09.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springGroupS09.common.Pagination;
import com.spring.springGroupS09.service.CustomerService;
import com.spring.springGroupS09.vo.InquiryReplyVO;
import com.spring.springGroupS09.vo.InquiryVO;
import com.spring.springGroupS09.vo.PageVO;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	@Autowired
	CustomerService customerService;
	
	@Autowired
	Pagination pagination;
	
	// faq 리스트보기
	@GetMapping("/faqList")
	public String faqListGet() {
		return "customer/faqList";
	}
	
	//1:1문의 리스트보기
	@GetMapping("/inquiry/inquiryList")
	public String inquiryListGet(Model model, HttpSession session, PageVO pageVO,
				@RequestParam(name="part", defaultValue="전체", required = false) String part
			) {
			// 세션 값 가져오기
			String mid = (String) session.getAttribute("sMid");
			Integer levelObj = (Integer) session.getAttribute("sLevel");
			
			// 로그인 여부 체크
			if(mid == null || levelObj == null) {
				return "redirect:/member/memberLogin";
			}
			
			int level = levelObj;
			
			// 관리자일 경우 mid 변경
			if(level == 0) mid = "admin";
			// 페이징 처리
			pageVO.setSection("inquiry");
			pageVO.setPart(part);
			pageVO.setSearchString(mid);
			pageVO = pagination.pagination(pageVO);
			
			// DB 조회
			List<InquiryVO> vos = customerService.getInquiryList(pageVO.getStartIndexNo(), pageVO.getPageSize(), part, mid);
			// 모델 저장
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("part", part);
		
			return "customer/inquiry/inquiryList";
	}
	
	//1:1문의 작성하기 폼
	@GetMapping("/inquiry/inquiryInput")
	public String inquiryInputGet(Model model, @RequestParam(name="pag", defaultValue = "1") int pag) {
		
		model.addAttribute("pag", pag);
		return "customer/inquiry/inquiryInput";
	}

	@PostMapping("/inquiry/inquiryInput")
	public String inquiryInputPost(MultipartHttpServletRequest file, InquiryVO vo, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		vo.setMid(mid);
		
		// VO 값 확인
    System.out.println("====== InquiryVO ======");
    System.out.println("mid: " + vo.getMid());
    System.out.println("title: " + vo.getTitle());
    System.out.println("part: " + vo.getPart());
    System.out.println("content: " + vo.getContent());
    System.out.println("FName: " + vo.getFName());
    System.out.println("FSName: " + vo.getFSName());
		
		customerService.setInquiryInput(file, vo);
		
		return "redirect:/message/inquiryInputOk";
	}
	
	// 문의글 상세보기
	@GetMapping("/inquiry/inquiryView")
	public String inquiryViewGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag
			) {
		InquiryVO vo = customerService.getInquiryView(idx);
		
		// 해당 문의글의 답변글 가져오기
		InquiryReplyVO reVO = customerService.getInquiryReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		model.addAttribute("pag", pag);
		
		return "customer/inquiry/inquiryView";
	}
	
	
	
	
	
}
