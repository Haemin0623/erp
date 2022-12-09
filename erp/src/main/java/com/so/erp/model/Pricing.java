package com.so.erp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Pricing {
	
	private String buyerCd;
    private String productCd;
    private Date startdate;
    private Date enddate;
    private int price;
    private String currency;
    private int discountrate;
    private Date adddate;
    private String del;
    private Date statusdate;
    
//  최종 판매가
    private double finalPrice;
//  리스트 순번
    private int number;
//  검색용
    private Date validDate;
    private int startPrice;
    private int endPrice;
//  조인용
    private String bname;
    private String pname;
//  정렬용
    private int sortBuyerCd;
    private int sortProductCd;
    private int sortPrice;
    private int sortStartdate;
    private int sortEnddate;
    private int sortDiscountrate;
    private int sortFinalPrice;
    private int sortCurrency;
    private int sortAdddate;
    private int sortStatusdate;
//  페이징용
    private int currentPage;
   	private int rowPerPage;
   	private int total;
   	private int totalPage;
   	private int pagePerBlock = 10;
   	private int startPage;
   	private int endPage;
   	private int startRow;
   	private int endRow;
   	private String pageNum;
   	
   	public void pagingBean(int currentPage, int rowPerPage, int total) {
   		
   		this.currentPage = currentPage;
   		this.rowPerPage = rowPerPage; 
   		this.total = total;
   		
   		totalPage = (int)(Math.ceil((double)total/rowPerPage));
   		
   		startPage = currentPage - (currentPage - 1) % pagePerBlock;		
   		endPage = startPage + pagePerBlock - 1;
   		
   		if (endPage > totalPage) {
   			endPage = totalPage;
   		}
   	}
}
