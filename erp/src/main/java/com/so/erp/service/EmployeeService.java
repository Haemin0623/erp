package com.so.erp.service;

import java.util.List;

import com.so.erp.model.Employee;

public interface EmployeeService {

	List<Employee> list();

	void insert(Employee employee);

	List<Employee> search(Employee employee);

	void update(Employee employee);

	Employee select(String employeeCd);

}
