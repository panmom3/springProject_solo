package com.spring.springGroupS09.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.service.BoardService;
import com.spring.springGroupS09.service.MemberService;
import com.spring.springGroupS09.vo.PageVO;

@Service
public class Pagination {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	MemberService memberService;
	
	/*
	 * @Autowired AdminService adminService;
	 */

	public PageVO pagination(PageVO pageVO) {
		int pag = pageVO.getPag() == 0 ? 1: pageVO.getPag();
		int pageSize = pageVO.getPageSize() == 0 ? 10 : pageVO.getPageSize();
		int level = pageVO.getLevel() == 0 ? 99 : pageVO.getLevel();
		String part = pageVO.getPart() == null ? "" : pageVO.getPart();
		
		int totRecCnt = 0;
		if(pageVO.getSection().equals("board")) {
			if(pageVO.getSearch() == null) totRecCnt = boardService.getTotRecCnt("","");
			else totRecCnt = boardService.getTotRecCnt(pageVO.getSearch(), pageVO.getSearchString());
		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		if(pageVO.getSearch() != null) {
			if(pageVO.getSearch().equals("title")) pageVO.setSearchStr("글제목");
			else if(pageVO.getSearch().equals("nickName")) pageVO.setSearchStr("닉네임");
			else if(pageVO.getSearch().equals("content")) pageVO.setSearchStr("글내용");
		}
		pageVO.setSearch(pageVO.getSearch());
		pageVO.setSearchString(pageVO.getSearchString());
		
		pageVO.setPart(part);
		pageVO.setBoardFlag(pageVO.getBoardFlag());
		
		pageVO.setLevel(level);
		
		return pageVO;
	}
}
