package com.mobile.inconvenient;

public class AttachFile {
	private int fileNum = 0;
	private int fileGroup = 0; // 불편사항:10000,설문:20000
	private String filePath = "";
	private String fileNm = "";
	private String fileExt = "";
	private int fileSize = 0;
	
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public int getFileGroup() {
		return fileGroup;
	}
	public void setFileGroup(int fileGroup) {
		this.fileGroup = fileGroup;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}
	public String getFileExt() {
		return fileExt;
	}
	public void setFileExt(String fileExt) {
		this.fileExt = fileExt;
	}
	public int getFileSize() {
		return fileSize;
	}
	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}
}
