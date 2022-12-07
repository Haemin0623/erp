package com.so.erp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Buyer {
	
	private String buyerCd;
    private String countryCd; 
    private String bname;       
    private String manager;    
    private String address;   
    private String tel;        
    private String email;
    private Date adddate;
    private String del;        
    private Date statusdate;

    private int sortBuyerCd;
    private int sortBname;
    private int sortManager;
    private int sortTel;
    private int sortEmail;
    private int sortAddress;
    private int sortCountryCd;
    private int sortAdddate;
    private int sortStatusDate;
    
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
