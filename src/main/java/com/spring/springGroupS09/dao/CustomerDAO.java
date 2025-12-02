package com.spring.springGroupS09.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.InquiryVO;

public interface CustomerDAO {

	int getTotRecCnt(@Param("part") String part, @Param("mid") String mid);
	
	int getTotRecCntAdmin(@Param("part") String part);

	List<InquiryVO> getInquiryList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("mid") String mid);

	void setInquiryInput(@Param("vo") InquiryVO vo);



}
