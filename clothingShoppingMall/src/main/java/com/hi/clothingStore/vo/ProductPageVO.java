package com.hi.clothingStore.vo;

public class ProductPageVO {

	private int rowPerPage; //페이지당 행의 수 
	private int beginRow;  //시작 행
	private String product_category;  //카테고리 추가 
	
	public int getRowPerPage() {
		return rowPerPage;
	}
	public void setRowPerPage(int rowPerPage) {
		this.rowPerPage = rowPerPage;
	}
	public int getBeginRow() {
		return beginRow;
	}
	public void setBeginRow(int beginRow) {
		this.beginRow = beginRow;
	}
	public String getProduct_category() {
		return product_category;
	}
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}
	
	@Override
	public String toString() {
		return "ProductPageVO [rowPerPage=" + rowPerPage + ", beginRow=" + beginRow + ", product_category="
				+ product_category + "]";
	}
	
	
}
