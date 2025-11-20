package com.spring.springGroupS09.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/event")
public class EventController {
	// 이벤트소식 리스트보기
	@GetMapping("/eventList")
	public String eventListGet() {
		
		return "event/eventList";
	}
}
