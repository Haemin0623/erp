package com.so.erp.model;

import java.sql.Date;

import lombok.Data;

@Data
public class Employee {

	private String employeeCd;
    private String ename;
    private String password;
    private String department;
    private String job;
    private String authority;
    private Date adddate;
    private String del;
    private Date statusdate;
}
