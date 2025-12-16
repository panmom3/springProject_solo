package com.spring.springGroupS09.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.common.ProjectProvide;
import com.spring.springGroupS09.dao.TravelDAO;
import com.spring.springGroupS09.vo.BoardVO;
import com.spring.springGroupS09.vo.TravelVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class TravelServiceImpl implements TravelService {

	@Autowired
	TravelDAO travelDAO;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<TravelVO> getTravelList(int startIndexNo, int pageSize, String part, String choice) {
		return travelDAO.getTravelList(startIndexNo, pageSize, part, choice);
	}

	@Override
	public int imgCheck(TravelVO vo, String realPath) {
	    int res = 0;
	    String content = vo.getContent();
	    if (content == null || content.indexOf("src=\"/") == -1) return res;

	    // 정규식: src="..." 부분을 모두 찾아서 내부 경로만 추출
	    Pattern pattern = Pattern.compile("src=\"/springGroupS09/data/ckeditor/([^\"]+)\"");
	    Matcher matcher = pattern.matcher(content);

	    boolean firstSw = true;
	    String firstFile = "";

	    while (matcher.find()) {
	        String imgFile = matcher.group(1); // src 내부 파일명만 추출 (예: "210201125255+0900_m13.jpg")

	        if (firstSw) {
	            firstFile = imgFile;
	            vo.setThumbnail(firstFile);
	            firstSw = false;
	        }

	        // 원본 → 복사 경로 설정
	        String oriFilePath = realPath + "ckeditor/" + imgFile;
	        String copyFilePath = realPath + "photoGallery/" + imgFile;

	        projectProvide.fileCopyCheck(oriFilePath, copyFilePath);
	    }

	    // ckeditor → photoGallery 경로 치환
	    vo.setContent(content.replace("/data/ckeditor/", "/data/photoGallery/"));

	    // 썸네일 생성
	    if (!firstFile.isEmpty()) {
	        try {
	            realPath += "photoGallery/";
	            File realFileName = new File(realPath + firstFile);
	            File thumbnailFile = new File(realPath + "s_" + firstFile);

	            int width = 450;
	            int height = 240;
	            Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);

	            vo.setThumbnail("s_" + firstFile);
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }

	    // DB 저장
	    if (vo.getIdx() == 0) res = travelDAO.setTravelInput(vo);
	    else res = travelDAO.setTravelUpdate(vo);

	    return res;
	}

	@Override
	public void setTravelReadNumPlus(int idx) {
		travelDAO.setTravelReadNumPlus(idx);
	}

	@Override
	public TravelVO getTravelIdxSearch(int idx) {
		return travelDAO.getTravelIdxSearch(idx);
	}

	@Override
	public ArrayList<TravelVO> getTravelReply(int idx) {
		return travelDAO.getTravelReply(idx);
	}

	@Override
	public void setTravelGoodPlus(int idx) {
		travelDAO.setTravelGoodPlus(idx);
	}

	@Override
	public int setTravelReplyInput(TravelVO vo) {
		return travelDAO.setTravelReplyInput(vo);
	}

	@Override
	public int setTravelReplyDelete(int idx) {
		return travelDAO.setTravelReplyDelete(idx);
	}

	@Override
	public void setTravelDelete(int idx) {
		travelDAO.setTravelDelete(idx);
	}

	@Override
	public List<TravelVO> getLatestTitles() {
		return travelDAO.getLatestTitles();
	}

	@Override
	public void imgDelete(String content) {
		if(content == null || content.trim().equals("")) return;
		
		// src="...경로..." 형태 찾기
		Pattern pattern = Pattern.compile("src=\"([^\"]+)\"");
	    Matcher matcher = pattern.matcher(content);
	    
	    while(matcher.find()) {
	    	// src 내부 전체 경로
	    	String imgPath = matcher.group(1);
	    	
	    	// 마지막 / 뒤의 파일명만 추출
	    	String imgFile = imgPath.substring(imgPath.lastIndexOf("/") + 1);
	    	
	    	// 파일 삭제실행
	    	projectProvide.fileDelete(imgFile, "photoGallery");
	    }
	}



	
}
