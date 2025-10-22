package com.spring.springGroupS09.service;

import java.util.List;

import com.spring.springGroupS09.vo.TravelVO;

public interface TravelService {

	List<TravelVO> getTravelList(int startIndexNo, int pageSize, String part);

}
