package com.cduestc.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cduestc.crud.bean.Department;
import com.cduestc.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getDept(){
		List<Department> dList = departmentMapper.selectByExample(null);
		return dList;
	}
}
