package com.operation.visiter;

public class Biz_visiter_state 
{
	private int rec_num = 0;
	private String visitor_id = "";
	private String visitor_nm = "";
	private String festival_cd = "";
	private String festival_nm = "";
	private String festival_hall_cd = "";
	private String festival_hall_nm = "";
	private String visit_ymd = "";
	
	private int prev_cnt = 0;
	private int today_cnt = 0;
	private int total_cnt = 0;
	
	public int getRec_num() {
		return rec_num;
	}
	public void setRec_num(int rec_num) {
		this.rec_num = rec_num;
	}
	public String getVisitor_id() {
		return visitor_id;
	}
	public void setVisitor_id(String visitor_id) {
		this.visitor_id = visitor_id;
	}
	public String getVisitor_nm() {
		return visitor_nm;
	}
	public void setVisitor_nm(String visitor_nm) {
		this.visitor_nm = visitor_nm;
	}
	public String getFestival_cd() {
		return festival_cd;
	}
	public void setFestival_cd(String festival_cd) {
		this.festival_cd = festival_cd;
	}
	public String getFestival_nm() {
		return festival_nm;
	}
	public void setFestival_nm(String festival_nm) {
		this.festival_nm = festival_nm;
	}
	public String getFestival_hall_cd() {
		return festival_hall_cd;
	}
	public void setFestival_hall_cd(String festival_hall_cd) {
		this.festival_hall_cd = festival_hall_cd;
	}
	public String getFestival_hall_nm() {
		return festival_hall_nm;
	}
	public void setFestival_hall_nm(String festival_hall_nm) {
		this.festival_hall_nm = festival_hall_nm;
	}
	public String getVisit_ymd() {
		return visit_ymd;
	}
	public void setVisit_ymd(String visit_ymd) {
		this.visit_ymd = visit_ymd;
	}
	public int getPrev_cnt() {
		return prev_cnt;
	}
	public void setPrev_cnt(int prev_cnt) {
		this.prev_cnt = prev_cnt;
	}
	public int getToday_cnt() {
		return today_cnt;
	}
	public void setToday_cnt(int today_cnt) {
		this.today_cnt = today_cnt;
	}
	public int getTotal_cnt() {
		return total_cnt;
	}
	public void setTotal_cnt(int total_cnt) {
		this.total_cnt = total_cnt;
	}
	
	
}
