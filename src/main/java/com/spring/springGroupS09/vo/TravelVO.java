package com.spring.springGroupS09.vo;

import lombok.Data;

@Data
public class TravelVO {
	private int idx;
	private String mid;
	private String part;
	private String title;
	private String content;
	private String thumbnail;
	private String address;
	private String pDate;
	private int goodCount;
	private int readNum;
	private String tags;
	
	//travelReply.sql(댓글 처리시에 필요한 필드들)
	private int replyIdx;
	private int travelIdx;
	private String prDate;
	
	private int replyCnt; // 댓글개수
}
