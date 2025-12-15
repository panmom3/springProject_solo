package com.spring.springGroupS09.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdCheck(@Param("mid") String mid);

	MemberVO getMemberNickCheck(@Param("nickName") String nickName);
	
	int setMemberJoin(@Param("vo") MemberVO vo);

	void setMemberTodayCntClear(@Param("mid") String mid);

	void setMemberInforUpdate(@Param("mid") String mid, @Param("point") int point);

	int setMemberPwdChange(@Param("mid") String mid, @Param("pwd") String pwd);

	int setMemberUpdateOk(@Param("vo") MemberVO vo);

	int getTotRecCnt();

	List<MemberVO> getMemberLevelCount(@Param("level") int level);

	List<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize, @Param("level")int level);

	int setUserDelete(@Param("mid") String mid);


}
