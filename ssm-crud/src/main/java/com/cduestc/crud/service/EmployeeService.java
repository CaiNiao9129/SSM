package com.cduestc.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cduestc.crud.bean.Employee;
import com.cduestc.crud.bean.EmployeeExample;
import com.cduestc.crud.bean.EmployeeExample.Criteria;
import com.cduestc.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getEmps(){
		
		return employeeMapper.selectByExampleWithDept(null);
	}
	
	public void saveEmp(Employee employee){
		employeeMapper.insertSelective(employee);
	}
	
	public boolean checkEmpName(String empName){
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(employeeExample);
		return count == 0;
	}	
	
	public Employee getEmp(Integer id){
		return employeeMapper.selectByPrimaryKeyWithDept(id);
	} 
	
	public void updateEmp(Employee employee){
		employeeMapper.updateByPrimaryKeySelective(employee);
	}
	public void deleteEmp(Integer id){
		employeeMapper.deleteByPrimaryKey(id);
	}
	public void deleteBatch(List<Integer> ids){
		EmployeeExample employeeExample = new EmployeeExample();
		Criteria criteria = employeeExample.createCriteria();
		//delete employee where id in (....);
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(employeeExample);
	}
	
}
