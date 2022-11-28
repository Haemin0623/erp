package com.so.erp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Product {
	
	private String productCd;
    private String name;
    private String volume;
    private String unit;
    private String category;
    private Date adddate;
    private String del;
    private Date deldate;
	
}
