package com.spring.springGroupS09.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springGroupS09.vo.InquiryReplyVO;
import com.spring.springGroupS09.vo.InquiryVO;

public interface CustomerService {

	List<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part, String mid);

	//void setInquiryInput(MultipartFile file, InquiryVO vo);

	InquiryVO getInquiryView(int idx);

	InquiryReplyVO getInquiryReply(int idx);

	void setInquiryInput(MultipartHttpServletRequest file, InquiryVO vo);

	int setInquiryUpdate(MultipartFile file, InquiryVO vo);

	int setInquiryDelete(int idx, String fSName);



}
