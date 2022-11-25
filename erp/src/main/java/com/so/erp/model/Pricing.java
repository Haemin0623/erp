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
    private String del;
    private Date deldate;

}
