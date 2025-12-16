package com.spring.springGroupS09.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.springGroupS09.vo.BoardVO;
import com.spring.springGroupS09.vo.TravelVO;

public interface TravelDAO {

	List<TravelVO> getTravelList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize, @Param("part")String part, @Param("choice") String choice);

	int setTravelInput(@Param("vo") TravelVO vo);

	int setTravelUpdate(@Param("vo") TravelVO vo);

	void setTravelReadNumPlus(@Param("idx") int idx);

	TravelVO getTravelIdxSearch(@Param("idx") int idx);

	List<String> getTravelPhotoList(@Param("content") String content);

	ArrayList<TravelVO> getTravelReply(@Param("idx") int idx);

	void setTravelGoodPlus(@Param("idx") int idx);

	int setTravelReplyInput(@Param("vo") TravelVO vo);

	int setTravelReplyDelete(@Param("idx") int idx);

	void setTravelDelete(@Param("idx") int idx);

	List<TravelVO> getLatestTitles();

}
