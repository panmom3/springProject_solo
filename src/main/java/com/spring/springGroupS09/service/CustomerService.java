package com.spring.springGroupS09.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS09.vo.InquiryVO;

public interface CustomerService {

	List<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part, String mid);

	void setInquiryInput(MultipartFile file, InquiryVO vo);



}
