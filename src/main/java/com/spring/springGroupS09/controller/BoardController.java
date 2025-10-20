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
import com.spring.springGroupS09.vo.MemberVO;
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
	// 1. 만약 content에 이미지를 등록하여 서버 파일시스템에 해당 그림이 저장되어 있다면, 저장된 그림(DB에 저장된 content필드)된 그림만 board폴더에 따로 보관('/data/ckeditor'폴더에서 '/data/board'폴더로 복사)한다.
		if(vo.getContent().indexOf("src=\"/") !=-1) boardService.imgCheck(vo.getContent());
		
		// 2. 이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 board폴더로 변경시킨다.
		vo.setContent(vo.getContent().replace("/data/ckeditor", "/data/board"));
		
		// 3. content안의 그림에 대한 정리와 모두 끝나면 변경된 내용을 vo에 담아서 DB에 저장한다.
		int res = boardService.setBoardInput(vo);
		// 4. 결과 메시지 리다이렉트
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
		
		// 로그인한 회원 정보에서 level 가져오기
		MemberVO memberVO = (MemberVO) session.getAttribute("sMember");
		if(memberVO != null) {
			session.setAttribute("sLevel", memberVO.getLevel());
		}
		
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

	// 게시글 수정폼보기
	@GetMapping("/boardUpdate")
	public String boardUpdateGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		BoardVO vo = boardService.getBoardContent(idx);
		
		// 수정화면으로 들어갈때, 기존 원본파일에 그림파일이 존재한다면, 현재폴더(board)에서 그림파일만 ckeditor폴더로 복사한다.
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgBackup(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
 		
		return "board/boardUpdate";
	}
	
	// 게시글 수정처리
	@PostMapping("/boardUpdate")
	public String boardUpdatePost(Model model, BoardVO vo,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없다.(DB자료와 수정자료를 비교한다)
		BoardVO origVO = boardService.getBoardContent(vo.getIdx());
		
		// content내용중에서 조금이라도 수정한 것이 있다면 사진에 대한 처리를 한다.
		if(!origVO.getContent().equals(vo.getContent())) {
			// 1.기존 board폴더에 그림파일이 존재했다면 원본그림파일 삭제처리
			if(origVO.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(origVO.getContent());
			// 2.content필드안에는 현재 board폴더로 설정되어 있기에, board폴더를 ckeditor로 변경처리한다.
			vo.setContent(vo.getContent().replace("/data/board", "/data/ckeditor"));
			// 3.board폴더의 그림파일 삭제 완료후(그림파일이 존재시), 입력시 작업과 같은 작업을 수행처리한다.
			if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheck(vo.getContent());
			// 4.이미지 작업(복사작업)을 모두 마치면, ckeditor폴더경로를 board폴더로 변경시킨다.
			vo.setContent(vo.getContent().replace("/data/ckeditor", "/data/board"));
		}
		int res = boardService.setBoardUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		if(res != 0) return "redirect:/message/boardUpdateOk";
		else return "redirect:/message/boardUpdateNo";
	}
	
	// 게시글 삭제처리
	@GetMapping("/boardDelete")
	public String boardDeleteGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		// 게시글에 사진이 존재한다면 서버에 저장된 사진을 먼저 삭제처리한다.
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		// 사진작업처리를 마치고 DB에 저장된 실제 정보레코드를 삭제처리한다.
		int res = boardService.setBoardDelete(idx);
		
		if(res != 0) return "redirect:/message/boardDeleteOk";
		else return "redirect:/message/boardDeleteNo";
	}
	
	// 검색기 처리
	@GetMapping("/boardSearchList")
	public String boardSearchListGet(Model model, PageVO pageVO) {
		pageVO.setSection("board");
		pageVO = pagination.pagination(pageVO);
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageVO.getPageSize(), pageVO.getSearch(), pageVO.getSearchString());
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "board/boardSearchList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
