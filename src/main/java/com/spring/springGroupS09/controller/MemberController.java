package com.spring.springGroupS09.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {

	// 로그인 폼
	@GetMapping("/memberLogin")
	public String memberLoginGet() {
		
		return "member/memberLogin";
	}
	
	//회원가입 폼
	@GetMapping("/memberJoin")
	public String memberJoinGet() {
		
		return "member/memberJoin";
	}
}
