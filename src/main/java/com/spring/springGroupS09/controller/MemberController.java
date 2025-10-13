package com.spring.springGroupS09.controller;

import java.time.LocalDateTime;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS09.common.ProjectProvide;
import com.spring.springGroupS09.service.MemberService;
import com.spring.springGroupS09.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService; 
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	ProjectProvide projectProvide;

	// 로그인 폼
	@GetMapping("/memberLogin")
	public String memberLoginGet(HttpServletRequest request) {
		// 쿠키를 검색해서 cMid가 있을때 가져와서 로그인창의 아이디입력박스에 뿌려준다.
			Cookie[] cookies = request.getCookies();

			if(cookies != null) {
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						request.setAttribute("mid", cookies[i].getValue());
						break;
					}
				}
			}
		
		return "member/memberLogin";
	}
	//일반 로그인 처리하기
	@PostMapping("/memberLogin")
	public String memberLoginPost(HttpSession session,
			HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "abio1234", required = false) String mid,
			@RequestParam(name="pwd", defaultValue = "1234", required = false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required = false) String idSave
		) {
		//  로그인 인증처리(스프링 시큐리티의 BCryptPasswordEncoder객체를 이용한 암호화되어 있는 비밀번호 비교하기)
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null) {
			// 로그인 인증완료시 처리할 부분(1.세션, 2.쿠키, 3.기타 설정값....)
			// 1.세션처리
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "우수회원";
			else if(vo.getLevel() == 2) strLevel = "정회원";
			else if(vo.getLevel() == 3) strLevel = "준회원";

			session.setAttribute("sMid", mid);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sLastDate", vo.getLastDate());
			
			// 2.쿠키 저장/삭제
			if(idSave.equals("on")) {
				Cookie cookieMid = new Cookie("cMid", mid);
				cookieMid.setPath("/");
				cookieMid.setMaxAge(60*60*24*7);		// 쿠키의 만료시간을 7일로 지정
				response.addCookie(cookieMid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cMid")) {
							cookies[i].setPath("/");
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			
			// 3. 기타처리(DB에 처리해야할것들(방문카운트, 포인트,... 등)
			// (2) 오늘 첫방문이면 todayCnt = 0, 오늘 첫방문인지를 체크하기 위한 변수 todaySw(1은첫방문, 0은 두번이상방문)
			int todaySw = 0;
			if(!LocalDateTime.now().toString().substring(0, 10).equals(vo.getLastDate().substring(0,10))) {
				memberService.setMemberTodayCntClear(mid);
				vo.setTodayCnt(0);
				todaySw = 1;
			}
			
			if(vo.getLevel() != 3) {
				int point = vo.getTodayCnt() < 5 ? 10 : 0;
				memberService.setMemberInforUpdate(mid, point);
			}
			else memberService.setMemberInforUpdate(mid, 0);
			
			//if(vo.getLevel() == 3 && todaySw == 0) memberService.setMemberInforUpdateMinus(mid);
			
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	// 일반 로그아웃 처리
	@GetMapping("/memberLogout")
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		session.invalidate();
		
		return "redirect:/message/memberLogout?mid="+mid;
	}
	
	// 로그인 완료시 회원방으로 이동처리
	@GetMapping("/memberMain")
	public String memberMainGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO mVo = memberService.getMemberIdCheck(mid);
		
		if (mVo == null) return "redirect:/member/memberLogin";  // 예외 처리
		
		model.addAttribute("mVo", mVo);
		
		if(mVo.getMid().equals("admin")) {
			return "redirect:admin/adminMain";
		}
		
		return "member/memberMain";
	}
	
	//회원가입 폼
	@GetMapping("/memberJoin")
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	// 회원가입처리
	@PostMapping("/memberJoin")
	public String memberJoinPost(MultipartFile fName, MemberVO vo) {
		
		// '아이디/닉네임' 중복체크
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirec:/message/idCheckNo";
		if(memberService.getMemberNickCheck(vo.getNickName()) != null) return "redirec:/message/nickNameCheckNo";
		
		// 비밀번호 암호화
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		// 회원 사진 등록처리(회원이 사진을 업로드 하지 않았을시는 photo필드를 'noimage.jpg'로 DB에 저장한다.
		// 회원 사진을 등록하였을경우는, 사진을 서버에 저장시키고, 저장시킨파일명을 DB에 저장처리한다.
		if(fName.getOriginalFilename().equals("")) vo.setPhoto("noimage.jpg");
		else vo.setPhoto(projectProvide.fileUpload(fName, vo.getMid(), "member"));
		
		int res = memberService.setMemberJoin(vo);
		
		if(res != 0) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	
	// 아이디 중복체크처리
	@ResponseBody
	@PostMapping("/memberIdCheck")
	public MemberVO memberIdCheckPost(String mid) {
		return memberService.getMemberIdCheck(mid);
	}
	
	//닉네임 중복체크처리
	@ResponseBody
	@PostMapping("/memberNickCheck")
	public MemberVO memberNickCheckPost(String nickName) {
		return memberService.getMemberNickCheck(nickName);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
