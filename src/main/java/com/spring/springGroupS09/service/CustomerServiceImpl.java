package com.spring.springGroupS09.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springGroupS09.common.ProjectProvide;
import com.spring.springGroupS09.dao.CustomerDAO;
import com.spring.springGroupS09.vo.InquiryReplyVO;
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
	public void setInquiryInput(MultipartHttpServletRequest file, InquiryVO vo) {
		try {
			List<MultipartFile> fileList = file.getFiles("file");
			String oFileNames = "";
			String sFileNames = "";
			
			for(MultipartFile f : fileList) {
				String oFileName = f.getOriginalFilename();
				String sFileName = projectProvide.saveFileName(oFileName);
			
				projectProvide.writeFile(f, sFileName, "inquiry");
				
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
			}
			oFileNames = oFileNames.substring(0, oFileNames.length()-1);
			sFileNames = sFileNames.substring(0, sFileNames.length()-1);
			vo.setFName(oFileNames);
			vo.setFSName(sFileNames);
			
			customerDAO.setInquiryInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public InquiryVO getInquiryView(int idx) {
		return customerDAO.getInquiryView(idx);
	}

	@Override
	public InquiryReplyVO getInquiryReply(int idx) {
		return customerDAO.getInquiryReply(idx);
	}
}
