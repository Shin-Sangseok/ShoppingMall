package com.hi.clothingStore.vo;

import java.sql.Timestamp;

public class ReviewVO {
	
/*
	review_idx        int(11)             not null
	product_idx      int(11)             not null
	user_id             varchar(45)      not null
	review_context   varchar(5000)   not null
	review_img        varchar(45)      null
	review_score      float               not null
	review_rgstdate  timestamp       not null
*/
	private int review_idx;
	private int product_idx;
	private String user_id;
	private String review_context;
	private String review_img;
	private float review_score;
	private Timestamp review_rgstdate;
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getProduct_idx() {
		return product_idx;
	}
	public void setProduct_idx(int product_idx) {
		this.product_idx = product_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getReview_context() {
		return review_context;
	}
	public void setReview_context(String review_context) {
		this.review_context = review_context;
	}
	public String getReview_img() {
		return review_img;
	}
	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}
	public float getReview_score() {
		return review_score;
	}
	public void setReview_score(float review_score) {
		this.review_score = review_score;
	}
	public Timestamp getReview_rgstdate() {
		return review_rgstdate;
	}
	public void setReview_rgstdate(Timestamp review_rgstdate) {
		this.review_rgstdate = review_rgstdate;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [review_idx=" + review_idx + ", product_idx=" + product_idx + ", user_id=" + user_id
				+ ", review_context=" + review_context + ", review_img=" + review_img + ", review_score=" + review_score
				+ ", review_rgstdate=" + review_rgstdate + "]";
	}
}
