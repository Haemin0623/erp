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
    
<<<<<<< HEAD
    private Date orderFromDate;
    private Date orderToDate;
=======
 // headEmpList 조인용
    private String ename;
    private String password;
    private String department;
    private String job;
    private String authority;
>>>>>>> 1af72d2 (승인 작업 중)
}
