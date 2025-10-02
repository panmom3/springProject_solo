package com.spring.springGroupS09.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.MemberVO;

public interface MemberDAO {

	MemberVO getMemberIdCheck(@Param("mid") String mid);



}
