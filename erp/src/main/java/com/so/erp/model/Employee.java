package com.so.erp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Employee {

	private String employeeCd;
    private String ename;
    private String password;
    private String department;
    private String job;
    private String authority;
    private Date adddate;
    private String del;
    private Date statusdate;
    
    private Date addFromDate;
    private Date addToDate;
    
    private int rn;
    
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
	
	private int sortEmployeeCd;
	private int sortEname;
	private int sortJob;
	private int sortDepartment;
	private int sortAdddate;
	private int sortAuthority;
	
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
