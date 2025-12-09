package com.spring.springGroupS09.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.InquiryReplyVO;
import com.spring.springGroupS09.vo.InquiryVO;

public interface AdminDAO {

	//1:1문의
	ArrayList<InquiryVO> getInquiryListAdmin(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	InquiryVO getInquiryContent(@Param("idx") int idx);

	InquiryReplyVO getInquiryReplyContent(@Param("idx") int idx);

	int setInquiryInputAdmin(@Param("vo") InquiryReplyVO vo);

	void setInquiryUpdateAdmin(@Param("inquiryIdx") int inquiryIdx);

}
