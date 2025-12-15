package com.spring.springGroupS09.service;

import java.util.List;

import com.spring.springGroupS09.vo.MemberVO;

public interface MemberService {

	MemberVO getMemberIdCheck(String mid);
	
	MemberVO getMemberNickCheck(String nickName);

	int setMemberJoin(MemberVO vo);

	void setMemberTodayCntClear(String mid);

	void setMemberInforUpdate(String mid, int point);

	int setMemberPwdChange(String mid, String pwd);

	int setMemberUpdateOk(MemberVO vo);

	int getTotRecCnt();

	List<MemberVO> getMemberLevelCount(int level);

	List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	int setUserDelete(String mid);




}
