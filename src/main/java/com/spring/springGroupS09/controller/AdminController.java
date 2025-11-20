package com.spring.springGroupS09.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS09.common.Pagination;
import com.spring.springGroupS09.service.AdminService;
import com.spring.springGroupS09.service.MemberService;
import com.spring.springGroupS09.vo.MemberVO;
import com.spring.springGroupS09.vo.PageVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	Pagination pagination;
	
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "admin/adminMain";
	}
	// 회원리스트	
	@GetMapping("/member/adMemberList")
	public String adMemberListGet(Model model, PageVO pageVO) {
		pageVO.setSection("member");
		pageVO = pagination.pagination(pageVO);
		
		List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(), pageVO.getPageSize(), pageVO.getLevel());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/member/adMemberList";
	}
	
	// 숙소등록 폼보기
	@GetMapping("/stay/adStayInput")
	public String adStayInputGet() {
		
		return "admin/stay/adStayInput";
	}
}
