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
    private String del;
    private Date deldate;
    
}
