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

import com.spring.springGroupS09.service.StayService;
import com.spring.springGroupS09.vo.ReservationVO;
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
	
	// 숙소상세보기
	@GetMapping("/stayContent")
	public String stayContentGet(Model model, @RequestParam(name="idx", required=true) int idx) {
		
		StayVO vo = stayService.getStayContent(idx);
		
		model.addAttribute("vo", vo);
		return "stay/stayContent";
	}
	
	// 숙소 등록하기 폼보기
	@GetMapping("/stayInput")
	public String stayInputGet() {
		return "stay/stayInput";
	}
	
	
	
	// 예약하기
	@PostMapping("/reservationInsert")
	public String reservationInsertPost(ReservationVO vo, Model model) {
		
		stayService.insertReservation(vo);
		
		int reservation_idx = vo.getReservation_idx();
		
		ReservationVO resVo = stayService.getReservationInfo(reservation_idx);
		
		model.addAttribute("vo", resVo);
		
		return "stay/reservationResult";
	}
	

	
}
