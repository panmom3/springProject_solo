package com.spring.springGroupS09.service;

import java.util.List;

import com.spring.springGroupS09.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(int startIndexNo, int pageSize, String search, String searchString);

	int getTotRecCnt(String search, String searchString);

	int setBoardInput(BoardVO vo);

	BoardVO getBoardContent(int idx);

}
