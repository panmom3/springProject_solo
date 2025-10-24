package com.spring.springGroupS09.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.springGroupS09.vo.TravelVO;

public interface TravelService {

	List<TravelVO> getTravelList(int startIndexNo, int pageSize, String part, String choice);

	int imgCheck(TravelVO vo, String realPath);

	void setTravelReadNumPlus(int idx);

	TravelVO getTravelIdxSearch(int idx);

	ArrayList<TravelVO> getTravelReply(int idx);

	void setTravelGoodPlus(int idx);

	int setTravelReplyInput(TravelVO vo);

	int setTravelReplyDelete(int idx);

	void setTravelDelete(int idx);


}
