package com.plan.budget;

public class Biz_budget {
	private String festival_cd = "";
	private int rec_num = 0;
	private String budget_div = "";
	private String budget_div_nm = "";
	private String detail_history = "";
	private int budget_money = 0;
	private String comp_ratio = "";
	private String other = "";
	private int cnt = 0;
	private String program_key = "";
	
	public String getFestival_cd() {
		return festival_cd;
	}
	public void setFestival_cd(String festival_cd) {
		this.festival_cd = festival_cd;
	}
	public int getRec_num() {
		return rec_num;
	}
	public void setRec_num(int rec_num) {
		this.rec_num = rec_num;
	}
	public String getBudget_div() {
		return budget_div;
	}
	public void setBudget_div(String budget_div) {
		this.budget_div = budget_div;
	}
	public String getDetail_history() {
		return detail_history;
	}
	public void setDetail_history(String detail_history) {
		this.detail_history = detail_history;
	}
	public int getBudget_money() {
		return budget_money;
	}
	public void setBudget_money(int budget_money) {
		this.budget_money = budget_money;
	}
	public String getComp_ratio() {
		return comp_ratio;
	}
	public void setComp_ratio(String comp_ratio) {
		this.comp_ratio = comp_ratio;
	}
	public String getOther() {
		
		return other!=null?other:"";
	}
	public void setOther(String other) {
		this.other = other;
	}
	public String getBudget_div_nm() {
		return budget_div_nm;
	}
	public void setBudget_div_nm(String budget_div_nm) {
		this.budget_div_nm = budget_div_nm;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getProgram_key() {
		return program_key;
	}
	public void setProgram_key(String program_key) {
		this.program_key = program_key;
	}
	
	
	
	
}
