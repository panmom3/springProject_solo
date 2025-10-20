package com.spring.springGroupS09.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.springGroupS09.dao.BoardDAO;
import com.spring.springGroupS09.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchString) {
		return boardDAO.getBoardList(startIndexNo, pageSize , search, searchString);
	}

	@Override
	public int getTotRecCnt(String search, String searchString) {
		return boardDAO.getTotRecCnt(search, searchString);
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public void setReadNumPlus(int idx) {
		boardDAO.setReadNumPlus(idx);
	}

	@Override
	public BoardVO getPreNextSearch(int idx, String str) {
		return boardDAO.getPreNextSearch(idx, str);
	}

	@Override
	public void imgCheck(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");

		// 정규식 패턴: ckeditor 경로가 포함된 src 속성 추출
    Pattern pattern = Pattern.compile("src=\"([^\"]*ckeditor/[^\"]+)\"");
    Matcher matcher = pattern.matcher(content);
		
    while (matcher.find()) {
      String srcPath = matcher.group(1); // 예: /springGroupS09/resources/data/ckeditor/파일명.jpg
      String fileName = srcPath.substring(srcPath.lastIndexOf("/") + 1); // 파일명만 추출

      String origFilePath = realPath + "ckeditor/" + fileName;
      String copyFilePath = realPath + "board/" + fileName;

      boolean copied = fileCopyCheck(origFilePath, copyFilePath);
      if (!copied) {
          System.err.println("이미지 복사 실패: " + fileName);
      }
    }
	}

	private boolean fileCopyCheck(String origFilePath, String copyFilePath) {
		File origFile = new File(origFilePath);
    if (!origFile.exists()) {
        System.err.println("원본 파일이 존재하지 않습니다: " + origFilePath);
        return false;
    }
		try {
			//원본 파일을 읽고(fis), 복사 위치에 새 파일을 씀(fos)
			FileInputStream fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];  //파일을 2KB씩 읽어서 복사
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			return true;
 		} catch (FileNotFoundException e) {
			e.printStackTrace();
			return true;
		} catch (IOException e) {
			e.printStackTrace();
			return false;
		}
	}

	@Override
	public void imgBackup(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");

		// 정규식 패턴: ckeditor 경로가 포함된 src 속성 추출
    Pattern pattern = Pattern.compile("src=\"([^\"]*ckeditor/[^\"]+)\"");
    Matcher matcher = pattern.matcher(content);
		
    while (matcher.find()) {
      String srcPath = matcher.group(1); // 예: /springGroupS09/resources/data/ckeditor/파일명.jpg
      String fileName = srcPath.substring(srcPath.lastIndexOf("/") + 1); // 파일명만 추출

      String origFilePath = realPath + "board/" + fileName;
      String copyFilePath = realPath + "ckeditor/" + fileName;

      boolean copied = fileCopyCheck(origFilePath, copyFilePath);
      if (!copied) {
          System.err.println("이미지 복사 실패: " + fileName);
      }
    }
	}

	@Override
	public void imgDelete(String content) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");

		// 정규식 패턴: ckeditor 경로가 포함된 src 속성 추출
    Pattern pattern = Pattern.compile("src=\"([^\"]*ckeditor/[^\"]+)\"");
    Matcher matcher = pattern.matcher(content);
		
    while (matcher.find()) {
      String srcPath = matcher.group(1); // 예: /springGroupS09/resources/data/ckeditor/파일명.jpg
      String fileName = srcPath.substring(srcPath.lastIndexOf("/") + 1); // 파일명만 추출

      String origFilePath = realPath + "board/" + fileName;

      fileDelete(origFilePath);
      
    }
	}
	//파일 삭제처리
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}
	
	
	
}
