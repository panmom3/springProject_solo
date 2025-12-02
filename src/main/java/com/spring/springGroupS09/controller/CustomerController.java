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
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS09.common.Pagination;
import com.spring.springGroupS09.service.CustomerService;
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
			String mid = (String) session.getAttribute("sMid");
			int level = (int) session.getAttribute("sLevel");
			if(level == 0) mid = "admin";
			
			pageVO.setSection("inquiry");
			pageVO.setPart(part);
			pageVO.setSearchString(mid);
			pageVO = pagination.pagination(pageVO);
			List<InquiryVO> vos = customerService.getInquiryList(pageVO.getStartIndexNo(), pageVO.getPageSize(), part, mid);
			
			model.addAttribute("vos", vos);
			model.addAttribute("pageVO", pageVO);
			model.addAttribute("part", part);
		
		return "customer/inquiry/inquiryList";
	}
	
	//1:1문의 작성하기 폼
	@GetMapping("/inquiry/inquiryInput")
	public String inquiryInputGet(Model model, int pag) {
		model.addAttribute("pag", pag);
		return "customer/inquiry/inquiryInput";
	}

	@PostMapping("/inquiry/inquiryInput")
	public String inquiryInputPost(MultipartFile file, InquiryVO vo) {
		customerService.setInquiryInput(file, vo);
		
		return "redirect:/message/inquiryInputOk";
	}
	
	
	
	
	
}
