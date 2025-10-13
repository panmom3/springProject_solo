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
		else if(msgFlag.equals("idCheckNo")) {
			model.addAttribute("message", "이미 사용중인 아이디가 있습니다.\\n아이디를 확인후 다시 회원가입하세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		else if(msgFlag.equals("nickNameCheckNo")) {
			model.addAttribute("message", "이미 사용중인 닉네임이 있습니다.\\n닉네임을 확인후 다시 회원가입하세요.");
			model.addAttribute("url", "/member/memberJoin");
		}
		
		return "include/message";
	}
}
