package com.spring.springGroupS09.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.springGroupS09.vo.PageVO;

@Controller
public class MessageController {
	
	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model, HttpSession session, PageVO pageVO,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx
			//@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			//@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
			) {
		
		
		if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("message", mid +"님 로그인 되었습니다.");
			model.addAttribute("url", "/member/memberMain");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "로그인 실패~~.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("message", mid + "님 로그아웃 되셨습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "회원에 가입되셨습니다.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원가입 실패!!");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "회원 정보를 수정하였습니다.");
			model.addAttribute("url", "/member/memberUpdate?mid="+mid);
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "회원 정보 수정실패~~");
			model.addAttribute("url", "/member/memberUpdate?mid="+mid);
		}
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("message", "이미 사용중인 아이디가 있습니다.\n아이디를 확인후 다시 회원가입하세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickNameCheckNo")) {
			model.addAttribute("message", "이미 사용중인 닉네임이 있습니다.\n닉네임을 확인후 다시 회원가입하세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("message", "이미 사용중인 닉네임이 있습니다.\n닉네임을 확인하세요.");
			model.addAttribute("url", "/member/memberUpdate?mid="+mid);
		}
		else if(msgFlag.equals("passwordChangeOk")) {
			model.addAttribute("message", "비밀번호를 변경했습니다. 다시 로그인후 사용하세요.");
			model.addAttribute("url", "/member/memberLogin");
		}
		else if(msgFlag.equals("passwordChangeNo")) {
			model.addAttribute("message", "비밀번호 변경 실패!!");
			model.addAttribute("url", "/member/memberPwdCheck");
		}
		else if(msgFlag.equals("boardInputOk")) {
			model.addAttribute("message", "게시글이 등록되었습니다.");
			model.addAttribute("url", "/board/boardList");
		}
		else if(msgFlag.equals("boardInputNo")) {
			model.addAttribute("message", "게시글 등록 실패~~");
			model.addAttribute("url", "/board/boardInput");
		}
		else if(msgFlag.equals("boardUpdateOk")) {
			model.addAttribute("message", "게시글을 수정되었습니다.");
			model.addAttribute("url", "/board/boardList?pag="+pageVO.getPag()+"&pageSize="+pageVO.getPageSize());
		}
		else if(msgFlag.equals("boardUpdateNo")) {
			model.addAttribute("message", "게시글 수정실패~!");
			model.addAttribute("url", "/board/boardUpdate?idx="+idx+"&pag="+pageVO.getPag()+"&pageSize="+pageVO.getPageSize());
		}
		else if(msgFlag.equals("boardDeleteOk")) {
			model.addAttribute("message", "게시글을 삭제하였습니다.");
			model.addAttribute("url", "/board/boardList?pag="+pageVO.getPag()+"&pageSize="+pageVO.getPageSize());
		}
		else if(msgFlag.equals("boardDeleteNo")) {
			model.addAttribute("message", "게시글 삭제실패~!");
			model.addAttribute("url", "/board/boardContent?idx="+idx+"&pag="+pageVO.getPag()+"&pageSize="+pageVO.getPageSize());
		}
		else if(msgFlag.equals("travelInputOk")) {
			model.addAttribute("message", "여행지 게시글이 등록되었습니다.");
			model.addAttribute("url", "/travel/travelList");
		}
		else if(msgFlag.equals("travelInputNo")) {
			model.addAttribute("message", "여행지 게시글 등록 실패");
			model.addAttribute("url", "/travel/travelInput");
		}
		else if(msgFlag.equals("travelDeleteOk")) {
			model.addAttribute("message", "추천여행지 게시글이 삭제되었습니다.");
			model.addAttribute("url", "/travel/travelList");
		}
		else if(msgFlag.equals("inquiryInputOk")) {
			model.addAttribute("message", "1:1 문의가 등록되었습니다.");
			model.addAttribute("url", "/customer/inquiry/inquiryList");
		}
		else if(msgFlag.equals("reservationCancelOk")) {
			model.addAttribute("message", "예약이 취소되었습니다.");
			model.addAttribute("url", "/stay/stayList");
		}
		
		return "include/message";
	}
}
