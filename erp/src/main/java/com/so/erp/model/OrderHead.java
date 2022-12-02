package com.so.erp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderHead {

	private String orderNo;
    private String buyerCd;
    private Date orderdate;
    private String employeeCd;
    private String reason;
    private String status;
    private Date statusdate;
    private String signempCd;
    private String del;
    
    private Date orderFromDate;
    private Date orderToDate;
    private String productCd;
    private Date requestFromDate;
    private Date requestToDate;
    
    
 // headEmpList 조인용
    private String ename;
    private String password;
    private String department;
    private String job;
    private String authority;
    

    private String pname;
    private int requestqty;
    private int price;
    

    private String volume;
    private String unit;
    private String category;
    private Date adddate;

    private String countryCd; 
    private String cname; 
    private String bname;       
    private String manager;    
    private String address;   
    private String tel;        
    private String email; 
    
    private Date requestdate;
    private int amount;
    private String remark;
    
    // 검색용
    private String auth;
}
