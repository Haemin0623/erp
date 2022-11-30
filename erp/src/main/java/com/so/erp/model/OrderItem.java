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

    
}
