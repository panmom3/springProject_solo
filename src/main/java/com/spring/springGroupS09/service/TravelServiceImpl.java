package com.spring.springGroupS09.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.common.ProjectProvide;
import com.spring.springGroupS09.dao.TravelDAO;
import com.spring.springGroupS09.vo.TravelVO;

@Service
public class TravelServiceImpl implements TravelService {

	@Autowired
	TravelDAO travelDAO;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<TravelVO> getTravelList(int startIndexNo, int pageSize, String part) {
		return travelDAO.getTravelList(startIndexNo, pageSize, part);
	}
	
}
