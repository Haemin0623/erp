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
    private String del;        
    private Date delDate;

}
