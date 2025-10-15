package com.spring.springGroupS09.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.springGroupS09.common.Pagination;
import com.spring.springGroupS09.service.BoardService;
import com.spring.springGroupS09.vo.BoardVO;
import com.spring.springGroupS09.vo.PageVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	Pagination pagination;
	
	@GetMapping("/boardList")
	public String boardListGet(Model model, PageVO pageVO) {
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageVO.getPageSize(), pageVO.getSearch(), pageVO.getSearchString());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "board/boardList";
	}
	
	// 게시글 등록 폼
	@GetMapping("/boardInput")
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	// 게시글 DB에 등록하기
	@PostMapping("/boardInput")
	public String boardInputPost(BoardVO vo) {
		
		int res = boardService.setBoardInput(vo);
		
		if(res != 0) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}
	
	// 글 내용 보기
	@GetMapping("/boardContent")
	public String boardContentGet(Model model, int idx) {
		
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo", vo);
		
		return "board/boardContent";
	}
	
	// 검색기 처리
	//@GetMapping("/boardSearchList")
//	public String boardSearchListGet(Model model, PageVO pageVO) {
//		pageVO.setSection("board");
//		pageVO = pagination.pagination(pageVO);
//		
//		List<BoardVO> vos =;
//	}
}
