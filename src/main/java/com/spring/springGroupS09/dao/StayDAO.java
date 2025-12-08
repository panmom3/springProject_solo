package com.spring.springGroupS09.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.ReservationVO;
import com.spring.springGroupS09.vo.StayVO;

public interface StayDAO {

	List<StayVO> getStaylist();

	StayVO getStayContent(@Param("idx") int idx);

	void insertReservation(ReservationVO vo);

	ReservationVO getReservationInfo(int reservation_idx);

	List<ReservationVO> getMyReservationList(String mid);

	void reservationCancel(int reservation_idx);

}
