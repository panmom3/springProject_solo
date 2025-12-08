package com.spring.springGroupS09.vo;

import lombok.Data;

@Data
public class ReservationVO {
	private int reservation_idx;
	private String mid;
	private int stay_idx;
	private String check_in;
	private String check_out;
	private int total_price;
	private String status;
	private String created_at;
	
	private String title;
}
