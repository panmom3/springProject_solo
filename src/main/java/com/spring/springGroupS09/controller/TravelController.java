package com.spring.springGroupS09.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	// 추천여행지 상세보기
	@SuppressWarnings("unchecked")
	@GetMapping("/travelContent")
	public String travelContentGet(HttpSession session, int idx, Model model, HttpServletRequest request) {
		// 게시글 조회수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "photoGallery" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			travelService.setTravelReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		// 조회자료 1건 담아서 내용보기로 보낼 준비
		TravelVO vo = travelService.getTravelIdxSearch(idx);
		model.addAttribute("vo", vo);
		
		// ckeditor의 사진정보만 뽑아서 넘겨주기(content화면에서 여러장의 사진을 보이고자 함)
		// List<String> photoList = travelService.getTravelPhotoList(vo.getContent());
		//request.setAttribute("photoList", photoList);
		
		// 댓글 처리
		ArrayList<TravelVO> replyVos = travelService.getTravelReply(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "travel/travelContent";
	}
	
	// 게시글 삭제하기
	@GetMapping("/travelDelete/{idx}")
	public String travelDeleteGet(@PathVariable("idx") int idx) {
		travelService.setTravelDelete(idx);
		return "redirect:/message/travelDeleteOk";
	}
	
	// 게시글 수정하기 폼보기
	
	
	// 댓글달기
	@ResponseBody
	@PostMapping("/travelReplyInput")
	public int travelReplyInputPost(TravelVO vo) {
		return travelService.setTravelReplyInput(vo);
	}
	
	// 댓글삭제
	@ResponseBody
	@PostMapping("/travelReplyDelete")
	public int travelReplyDeletePost(int idx) {
		return travelService.setTravelReplyDelete(idx);
	}
	
	// 좋아요 수 증가
	@ResponseBody
	@PostMapping("/travelGoodCheck")
	public int travelGoodCheckPost(HttpSession session, int idx) {
		int res = 0;
		// 좋아요 클릭수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "photoGallery" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			travelService.setTravelGoodPlus(idx);
			contentReadNum.add(imsiContentReadNum);
			res = 1;
		}
		session.setAttribute("sContentGood", contentReadNum);
		return res;
	}
	
	
	
	
	
	
	
}
