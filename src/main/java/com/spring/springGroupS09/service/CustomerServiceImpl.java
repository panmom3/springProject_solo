package com.spring.springGroupS09.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
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

	@Override
	public int setInquiryUpdate(MultipartFile file, InquiryVO vo) {
		int res = 0;
		// 사진을 변경처리 했다면 사진작업 처리후 DB에 갱신작업처리한다.
		try {
			String oFileName = file.getOriginalFilename();
			if(oFileName != null && !oFileName.equals("")) {
				// 기존에 존재하는 파일 삭제
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
				File deleteFile = new File(realPath + vo.getFSName());
				if(deleteFile.exists()) deleteFile.delete();  //파일이 존재하면 삭제
				
				// 새로 업로드되는 파일의 이름을 부여후 저장시키고, vo에 set시킨다.
				String saveFileName = UUID.randomUUID().toString().substring(0,4) + "_" + oFileName;
				projectProvide.writeFile(file, saveFileName, "inquiry");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			else {
				vo.setFName(vo.getFName());
				vo.setFSName(vo.getFSName());
			}
			res = customerDAO.setInquiryUpdate(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int setInquiryDelete(int idx, String fSName) {
		// 원본글에 사진이 있으면 사진을 삭제처리한다.
		if(fSName != null && !fSName.equals("")) {
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/inquiry/");
			File deleteFile = new File(realPath + fSName);
			if(deleteFile.exists()) deleteFile.delete();  //파일이 존재하면 삭제
		}
		return customerDAO.setInquiryDelete(idx);
	}
}
