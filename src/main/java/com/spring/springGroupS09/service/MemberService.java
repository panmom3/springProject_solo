package com.spring.springGroupS09.service;

import com.spring.springGroupS09.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberIdCheck(String mid);
	
	MemberVO getMemberNickCheck(String nickName);

	int setMemberJoin(MemberVO vo);

	void setMemberTodayCntClear(String mid);

	void setMemberInforUpdate(String mid, int point);




}
