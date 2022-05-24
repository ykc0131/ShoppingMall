package com.bean;

public class CommentCreateBean {
	private Integer board_id;
	private String comment;
	private String currentUri;
	
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCurrentUri() {
		return currentUri;
	}
	public void setCurrentUri(String currentUri) {
		this.currentUri = currentUri;
	}
	
	
}
