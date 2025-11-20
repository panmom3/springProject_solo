package com.spring.springGroupS09.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.dao.StayDAO;
import com.spring.springGroupS09.vo.StayVO;

@Service
public class StaySerivceImpl implements StayService {

	@Autowired
	StayDAO stayDAO;

	@Override
	public List<StayVO> getStaylist() {
		return stayDAO.getStaylist();
	}
}
