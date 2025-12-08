package com.spring.springGroupS09.service;

import java.util.List;

import com.spring.springGroupS09.vo.ReservationVO;
import com.spring.springGroupS09.vo.StayVO;

public interface StayService {

	List<StayVO> getStaylist();

	StayVO getStayContent(int idx);

	void insertReservation(ReservationVO vo);

	ReservationVO getReservationInfo(int reservation_idx);

	List<ReservationVO> getMyReservationList(String mid);

	void reservationCancel(int reservation_idx);
	
}
