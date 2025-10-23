package com.spring.springGroupS09.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.service.BoardService;
import com.spring.springGroupS09.service.MemberService;
import com.spring.springGroupS09.service.TravelService;
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
		int pag = pageVO.getPag() == 0 ? 1: pageVO.getPag(); // pageVO에 페이지 번호(pag)가 0이면 기본값으로 1을 사용
		int pageSize = pageVO.getPageSize() == 0 ? 10 : pageVO.getPageSize(); //한 페이지에 표시할 게시글 개수(pageSize)가 없으면 기본값 10개
		int level = pageVO.getLevel() == 0 ? 99 : pageVO.getLevel(); //회원 등급(level)이 지정되지 않았다면 기본값 99
		String part = pageVO.getPart() == null ? "" : pageVO.getPart(); //검색 구분(part, 예: 제목, 작성자 등)이 null이면 빈 문자열로 초기화
		
		int totRecCnt = 0;
		if(pageVO.getSection().equals("board")) {
			if(pageVO.getSearch() == null) totRecCnt = boardService.getTotRecCnt("",""); //게시글 총 개수를 가져옴. 검색 조건이 없으면 전체 게시글 수
			else totRecCnt = boardService.getTotRecCnt(pageVO.getSearch(), pageVO.getSearchString()); //검색 조건이 있으면 해당 검색어로 필터링된 게시글 수
		}
		else if(pageVO.getSection().equals("member")) {
			if(level == 99)	totRecCnt = memberService.getTotRecCnt(); //전체 회원 수 조회
			else totRecCnt = memberService.getMemberLevelCount(level).size(); //해당 등급 회원 수만 조회
		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1; // 총 페이지 수 계산. 만약 나누어떨어지지 않으면 마지막 페이지가 하나 더 필요하므로 +1.
		int startIndexNo = (pag - 1) * pageSize; //현재 페이지의 시작 인덱스
		int curScrStartNo = totRecCnt - startIndexNo; //현재 화면에서의 글 번호 시작 값
		
		int blockSize = 3; //한 화면에 보여줄 “페이지 번호 블록 크기”
		int curBlock = (pag - 1) / blockSize; //현재 블록 번호 계산
		int lastBlock = (totPage - 1) / blockSize; //마지막 블록 번호 계산
		
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
