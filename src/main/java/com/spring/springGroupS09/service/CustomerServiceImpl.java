package com.spring.springGroupS09.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.springGroupS09.common.ProjectProvide;
import com.spring.springGroupS09.dao.CustomerDAO;
import com.spring.springGroupS09.vo.InquiryVO;

@Service
public class CustomerServiceImpl implements CustomerService {
	@Autowired
	CustomerDAO customerDAO;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<InquiryVO> getInquiryList(int startIndexNo, int pageSize, String part, String mid) {
		return customerDAO.getInquiryList(startIndexNo, pageSize, part, mid);
	}

	@Override
	public void setInquiryInput(MultipartFile file, InquiryVO vo) {
		try {
			String oFileName = file.getOriginalFilename();
			if(oFileName != null && !oFileName.equals("")) {
				String saveFileName = UUID.randomUUID().toString().substring(0,4) + "_" + oFileName;
				projectProvide.writeFile(file, saveFileName, "inquiry");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			customerDAO.setInquiryInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
}
