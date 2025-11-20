package com.spring.springGroupS09.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/customer")
public class CustomerController {
	// faq 리스트보기
	@GetMapping("/faqList")
	public String faqListGet() {
		
		return "customer/faqList";
	}
}
