package com.so.erp.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.so.erp.model.Employee;

@Repository
public class EmployeeDaoImpl implements EmployeeDao {

	@Autowired
	private SqlSessionTemplate sst;

	@Override
	public List<Employee> list() {
		return sst.selectList("employeens.list");
	}

	@Override
	public void insert(Employee employee) {
		sst.insert("employeens.insert", employee);
		
	}

	@Override
	public List<Employee> search(Employee employee) {
		return sst.selectList("employeens.search", employee);
	}

	@Override
	public void update(Employee employee) {
		sst.update("employeens.update", employee);
	}

}
