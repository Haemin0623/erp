package com.so.erp.model;

import java.sql.Date;


import lombok.Data;

@Data
public class OrderItem {

	private String orderNo;
    private String productCd;
    private int requestqty;
    private Date requestdate;
    private int price;
    private int amount;
    private String remark;
    
 // amount,  주문수량 천 단위, 표시
  	private String unitedAmount;
  	private String unitedrequestqty;
  	
// orderStatusList 조인용
    // orderHead
    private String buyerCd;
    private Date orderdate;
    private String employeeCd;
    private String reason;
    private String status;
    private Date statusdate;
    private String signempCd;
    // product
    private String pname;
    private String volume;
    private String unit;
    private String category;
    private Date adddate;
    // employee
//	private String employeeCd;
    private String ename;
    private String password;
    private String department;
    private String job;
    private String authority;
    // buyer
//	private String buyerCd;
    private String countryCd; 
    private String bname;       
    private String manager;    
    private String address;   
    private String tel;        
    private String email; 
    
    // 검색용
    //될지안될지모르겠따,.,
    private String signempName;
    private Date orderFromDate;
    private Date orderToDate;
    private Date requestFromDate;
    private Date requestToDate;

    private int sortOrderNo;
    private int sortBuyerCd;
    private int sortOrderDate;
    private int sortEmployeeCd;
    private int sortStatus;
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
