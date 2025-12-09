package com.spring.springGroupS09.service;

import java.util.ArrayList;

import com.spring.springGroupS09.vo.InquiryReplyVO;
import com.spring.springGroupS09.vo.InquiryVO;

public interface AdminService {

	ArrayList<InquiryVO> getInquiryListAdmin(int startIndexNo, int pageSize, String part);

	InquiryVO getInquiryContent(int idx);

	InquiryReplyVO getInquiryReplyContent(int idx);

	int setInquiryInputAdmin(InquiryReplyVO vo);

	void setInquiryUpdateAdmin(int inquiryIdx);

}
