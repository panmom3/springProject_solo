package com.spring.springGroupS09.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@GetMapping("/adminMain")
	public String adminMainGet() {
		return "admin/adminMain";
	}
}
