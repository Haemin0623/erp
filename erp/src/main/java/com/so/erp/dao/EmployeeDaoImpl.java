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

	@Override
	public Employee select(String employeeCd) {
		return sst.selectOne("employeens.select",employeeCd);
	}

	@Override
	public int getTotal(Employee employee) {
		return sst.selectOne("employeens.getTotal", employee);
	}

	@Override
	public void employeeDelete(String employeeCd) {
		sst.update("employeens.employeeDelete", employeeCd);
		
	}

	@Override
	public void employeeRestore(String employeeCd) {
		sst.update("employeens.employeeRestore", employeeCd);
		
	}
	@Override
	public int getSALCount(String department) {
		return sst.selectOne("employeens.getSALCount", department);
	}

	@Override
	public Employee listForExcel(Employee item) {
		return sst.selectOne("employeens.listForExcel", item);
	}

}
