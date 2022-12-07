package com.so.erp.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.so.erp.dao.EmployeeDao;
import com.so.erp.model.Employee;

@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeDao ed;

	@Override
	public List<Employee> list() {
		return ed.list();
	}

	@Override
	public void insert(Employee employee) {
		ed.insert(employee);
		
	}

	@Override
	public List<Employee> search(Employee employee) {
		return ed.search(employee);
	}

	@Override
	public void update(Employee employee) {
		ed.update(employee);
	}

	@Override
	public Employee select(String employeeCd) {
		return ed.select(employeeCd);
	}

	@Override
	public int getTotal(Employee employee) {
		return ed.getTotal(employee);
	}

	@Override
	public void employeeDelete(String employeeCd) {
		ed.employeeDelete(employeeCd);
	}

	@Override
	public void employeeRestore(String employeeCd) {
		ed.employeeRestore(employeeCd);
		
	}

	@Override
	public int getSALCount(String department) {
		return ed.getSALCount(department);
	}

	@Override
	public Employee listForExcel(Employee item) {
		return ed.listForExcel(item);
	}

}
