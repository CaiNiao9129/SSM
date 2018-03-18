package com.cduestc.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cduestc.crud.bean.Department;
import com.cduestc.crud.bean.Msg;
import com.cduestc.crud.service.DepartmentService;

@Controller
@RequestMapping("/Dept")
public class DepartmentController {

		@Autowired
		private DepartmentService departmentService;
		
		@RequestMapping("/getDept")
		@ResponseBody
		public Msg getDept(){
			List<Department> dList = departmentService.getDept();
			return Msg.success().add("depts",dList);
		}
}
