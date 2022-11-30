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
    private Date adddate;
    private String del;
    private Date statusdate;
    
//  최종 판매가
    private double finalPrice;
//  리스트 순번
    private int number;
//	페이징용
	private int startRow;
	private int endRow;
//    검색용
    private Date validDate;
    private int startPrice;
    private int endPrice;
}
