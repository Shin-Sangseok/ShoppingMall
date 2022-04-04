package com.hi.clothingStore.vo;

public class ProductPageVO {

	private int rowPerPage; //페이지당 들어갈 행의 수 
	private int beginRow; //시작 열
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
	@Override
	public String toString() {
		return "ProductPageVO [rowPerPage=" + rowPerPage + ", beginRow=" + beginRow + "]";
	}

	
	
}
