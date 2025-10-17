package com.spring.springGroupS09.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		pageVO.setSection("board");
		pageVO = pagination.pagination(pageVO);
		
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
		
	// 글 내용 보기(조회수증가:중복방지, '이전글/다음글')
	@SuppressWarnings("unchecked")
	@GetMapping("/boardContent")
	public String boardContentGet(Model model, int idx, HttpSession session, String boardFlag,
				@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
				@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		// 조회수 증가하기
		//boardService.setReadNumPlus(idx);
		
		// 게시글 조회수 증가 중복방지
		List<String> contentReadNum = (List<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			boardService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo",vo);
		model.addAttribute("pag",pag);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("boardFlag",boardFlag);
		
		// 이전글/다음글 처리
		BoardVO preVO = boardService.getPreNextSearch(idx, "preVO");
		BoardVO nextVO = boardService.getPreNextSearch(idx, "nextVO");
		
		model.addAttribute("preVO", preVO);
		model.addAttribute("nextVO", nextVO);
		
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
