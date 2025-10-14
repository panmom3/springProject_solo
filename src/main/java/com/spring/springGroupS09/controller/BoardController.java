package com.spring.springGroupS09.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS09.common.Pagination;
import com.spring.springGroupS09.service.BoardService;
import com.spring.springGroupS09.vo.BoardVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	Pagination pagination;
	
	@GetMapping("/boardList")
	public String boardListGet(Model model) {
		
		List<BoardVO> vos = boardService.getBoardList();
		
		model.addAttribute("vos", vos);
		
		return "board/boardList";
	}
}
