package com.so.erp.model;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import lombok.Data;

@Data
@Entity
public class Emp {
	// 데이터값에 null이 들어있는 경우에는 Integer권장함
	private int empno;
	private String ename;
	private String job;
	private Integer mgr;
	private Date hiredate;
	private int sal;
	private Integer comm;
	private int deptno;
	
	//관리자 이름 (테이블에 없는 값)
	private String mgrName;
	
	// join용 
	private String dname;
	private String loc;
	
	// join용 (테이블 전체 조인)
	private Dept dept;
	
	@Id
	@Column(name = "empno")
	public int getEmpno() {
		return empno;
	}
	
	// Emp 데이터 여러 건에 Dept 데이터 한 건 (하나의 부서에, 여러명의  직원 , 부서의 입장에서 ManyToOne)
	@ManyToOne
	@JoinColumn(name = "deptno")
	public Dept getDept() {
		return dept;
	}
}
