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
}
