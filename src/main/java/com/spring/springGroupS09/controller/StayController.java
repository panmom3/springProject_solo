package com.spring.springGroupS09.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS09.service.StayService;
import com.spring.springGroupS09.vo.StayVO;

@Controller
@RequestMapping("/stay")
public class StayController {
	
	@Autowired
	StayService stayService;
	
	// 숙소 리스트보기
	@GetMapping("/stayList")
	public String stayListGet(Model model) {
		
		List<StayVO> vos = stayService.getStaylist();
		
		model.addAttribute("vos", vos);
		
		return "stay/stayList";
	}
	
	// 숙소 등록하기 폼보기
	@GetMapping("/stayInput")
	public String stayInputGet() {
		return "stay/stayInput";
	}
}
