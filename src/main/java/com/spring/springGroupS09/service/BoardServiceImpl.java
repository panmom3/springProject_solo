package com.spring.springGroupS09.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.dao.BoardDAO;
import com.spring.springGroupS09.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList() {
		return boardDAO.getBoardList();
	}
}
