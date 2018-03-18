package com.cduestc.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cduestc.crud.bean.Employee;
import com.cduestc.crud.bean.Msg;
import com.cduestc.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@RequestMapping("/Employee")
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	/*
	 * jsr303:检验 加入hibernate validator Jar包
	 * 		JSR303数据校验支持Tomcat7以上版本
	 * 		Tomcat7以下的服务器：对于el表达式给服务器lib包中替换新的标准el
	 */
	
	@RequestMapping(value="/deleteEmp/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpOneOrMore(@PathVariable("empIds")String ids){
		//批量删除
		if(ids.contains("-")){
			List<Integer> idList = new ArrayList<Integer>();
			String[] idS = ids.split("-");
			for(String id:idS){
				idList.add(Integer.parseInt(id));
			}
			employeeService.deleteBatch(idList);
		}else{
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
		
	}
	@RequestMapping(value="/saveEmp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg update(Employee employee){
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
		
	}
	@RequestMapping(value="/getEmp/{empId}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("empId")Integer id){
		
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp",employee);
	}
	
	@RequestMapping("/checkEmp")
	@ResponseBody
	public Msg checkEmp(@RequestParam("empName")String empName){
		//判断用户名是否是合法的
		String regName = "(^[a-zA-Z0-9]{2,10}$)|(^[\u2E80-\u9FFF]{2,10})";
		if(!empName.matches(regName)){
			return Msg.fail().add("va_msg","用户名必须2-10位英文、数字或汉字组成");
		}
		boolean b = employeeService.checkEmpName(empName);
		
		if(b){
			return Msg.success();
		}
		else {
			return Msg.fail().add("va_msg", "用户名已经存在");
		}
	}
	
	@RequestMapping(value="/saveEmp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		
		if(result.hasErrors()){
			Map<String, Object> map =new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors){
				System.out.println("错误的字段名"+ fieldError.getField());
				System.out.println("错误的信息" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			//ajax用的就是map保存信息的
			return Msg.fail().add("errorFields", map);
		}
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	
	/*@ResponseBody需要Jackson的jar包
	 * 
	 */
	@RequestMapping("/getAllEmps")
	@ResponseBody
	public Msg getAllEmpsWithJson(@RequestParam(value="page",defaultValue="1")Integer page){
		
		PageHelper.startPage(page,7);
		List<Employee> eList = employeeService.getEmps();
//		使用pageInfo包装查询结果,5代表连续显示多少页
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(eList,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
//	@RequestMapping("/getAllEmps2")
	public String getAllEmps(@RequestParam(value="page",defaultValue="1")Integer page,Model model){
		
		PageHelper.startPage(page,7);
		List<Employee> eList = employeeService.getEmps();
//		使用pageInfo包装查询结果,5代表连续显示多少页
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(eList,5);
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}
}
