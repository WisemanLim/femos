package com.operation.research;

public class Biz_research_q_item 
{
	private int rec_num = 0;
	private String sv_id = "";
	private int Sv_group = 0;
	private int q_num = 0;
	private String q_text = "";
	private String select_method = "";
	private String sort_method = "";
	
	public int getRec_num() {
		return rec_num;
	}
	public void setRec_num(int rec_num) {
		this.rec_num = rec_num;
	}
	public String getSv_id() {
		return sv_id;
	}
	public void setSv_id(String sv_id) {
		this.sv_id = sv_id;
	}
	public int getSv_group() {
		return Sv_group;
	}
	public void setSv_group(int sv_group) {
		Sv_group = sv_group;
	}
	public int getQ_num() {
		return q_num;
	}
	public void setQ_num(int q_num) {
		this.q_num = q_num;
	}
	public String getQ_text() {
		return q_text;
	}
	public void setQ_text(String q_text) {
		this.q_text = q_text;
	}
	public String getSelect_method() {
		return select_method;
	}
	public void setSelect_method(String select_method) {
		this.select_method = select_method;
	}
	public String getSort_method() {
		return sort_method;
	}
	public void setSort_method(String sort_method) {
		this.sort_method = sort_method;
	}
	
}
