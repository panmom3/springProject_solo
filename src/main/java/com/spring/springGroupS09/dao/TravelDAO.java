package com.spring.springGroupS09.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.TravelVO;

public interface TravelDAO {

	List<TravelVO> getTravelList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize, @Param("part")String part, @Param("choice") String choice);

	int setTravelInput(@Param("vo") TravelVO vo);

	int setTravelUpdate(@Param("vo") TravelVO vo);

}
