package com.hi.clothingStore.vo;

public class ProductPageVO {

	private int rowPerPage; //�������� ���� �� 
	private int beginRow; //������
	//private int startPage; //
	//private int endPage; //
  
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
