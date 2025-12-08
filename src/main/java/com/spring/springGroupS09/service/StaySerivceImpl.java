package com.spring.springGroupS09.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.springGroupS09.dao.StayDAO;
import com.spring.springGroupS09.vo.ReservationVO;
import com.spring.springGroupS09.vo.StayVO;

@Service
public class StaySerivceImpl implements StayService {

	@Autowired
	StayDAO stayDAO;

	@Override
	public List<StayVO> getStaylist() {
		return stayDAO.getStaylist();
	}

	@Override
	public StayVO getStayContent(int idx) {
		return stayDAO.getStayContent(idx);
	}

	@Override
	public void insertReservation(ReservationVO vo) {
		stayDAO.insertReservation(vo);
	}

	@Override
	public ReservationVO getReservationInfo(int reservation_idx) {
		return stayDAO.getReservationInfo(reservation_idx);
	}

	@Override
	public List<ReservationVO> getMyReservationList(String mid) {
		return stayDAO.getMyReservationList(mid);
	}

	@Override
	public void reservationCancel(int reservation_idx) {
		stayDAO.reservationCancel(reservation_idx);
	}
}
