package com.so.erp.dao;

import java.util.List;

import com.so.erp.model.Employee;

public interface EmployeeDao {

	List<Employee> list();

	void insert(Employee employee);

	List<Employee> search(Employee employee);

	void update(Employee employee);

}
