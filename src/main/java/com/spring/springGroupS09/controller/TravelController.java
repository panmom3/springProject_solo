package com.spring.springGroupS09.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS09.common.Pagination;
import com.spring.springGroupS09.service.TravelService;
import com.spring.springGroupS09.vo.TravelVO;

@Controller
@RequestMapping("/travel")
public class TravelController {
	
	@Autowired
	TravelService travelService;

	@Autowired
	Pagination pagination;
	
	// 추천여행지 리스트
	@GetMapping("/travelList")
	public String travelListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
			) {
			int startIndexNo = (pag - 1) * pageSize;
			
			String imsiChoice = "";
			if(choice.equals("최신순")) imsiChoice = "idx";
			else if(choice.equals("추천순")) imsiChoice = "goodCount";
			else if(choice.equals("조회순")) imsiChoice = "readNum";
			else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
			else imsiChoice = choice;
			
			List<TravelVO> vos = travelService.getTravelList(startIndexNo, pageSize, part, imsiChoice);
			
			model.addAttribute("vos", vos);
			model.addAttribute("part", part);
			model.addAttribute("choice", choice);
		
		return "travel/travelList";
	}
	
	// 추천여행지 등록하기 폼보기
	@GetMapping("/travelInput")
	public String travelInputGet() {
		return "travel/travelInput";
	}
	//추천여행지 등록하기
	@PostMapping("/travelInput")
	public String travelInputPost(TravelVO vo, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		int res = travelService.imgCheck(vo, realPath);
		if(res != 0) return "redirect:/message/travelInputOk";
		else return "redirect:/message/travelInputNo";
	}
	
	
	
	
	
	
}
