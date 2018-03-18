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
	 * jsr303:���� ����hibernate validator Jar��
	 * 		JSR303����У��֧��Tomcat7���ϰ汾
	 * 		Tomcat7���µķ�����������el���ʽ��������lib�����滻�µı�׼el
	 */
	
	@RequestMapping(value="/deleteEmp/{empIds}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpOneOrMore(@PathVariable("empIds")String ids){
		//����ɾ��
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
		//�ж��û����Ƿ��ǺϷ���
		String regName = "(^[a-zA-Z0-9]{2,10}$)|(^[\u2E80-\u9FFF]{2,10})";
		if(!empName.matches(regName)){
			return Msg.fail().add("va_msg","�û�������2-10λӢ�ġ����ֻ������");
		}
		boolean b = employeeService.checkEmpName(empName);
		
		if(b){
			return Msg.success();
		}
		else {
			return Msg.fail().add("va_msg", "�û����Ѿ�����");
		}
	}
	
	@RequestMapping(value="/saveEmp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		
		if(result.hasErrors()){
			Map<String, Object> map =new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError fieldError : errors){
				System.out.println("������ֶ���"+ fieldError.getField());
				System.out.println("�������Ϣ" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(),fieldError.getDefaultMessage());
			}
			//ajax�õľ���map������Ϣ��
			return Msg.fail().add("errorFields", map);
		}
		employeeService.saveEmp(employee);
		return Msg.success();
	}
	
	
	/*@ResponseBody��ҪJackson��jar��
	 * 
	 */
	@RequestMapping("/getAllEmps")
	@ResponseBody
	public Msg getAllEmpsWithJson(@RequestParam(value="page",defaultValue="1")Integer page){
		
		PageHelper.startPage(page,7);
		List<Employee> eList = employeeService.getEmps();
//		ʹ��pageInfo��װ��ѯ���,5����������ʾ����ҳ
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(eList,5);
		return Msg.success().add("pageInfo", pageInfo);
	}
	
//	@RequestMapping("/getAllEmps2")
	public String getAllEmps(@RequestParam(value="page",defaultValue="1")Integer page,Model model){
		
		PageHelper.startPage(page,7);
		List<Employee> eList = employeeService.getEmps();
//		ʹ��pageInfo��װ��ѯ���,5����������ʾ����ҳ
		PageInfo<Employee> pageInfo = new PageInfo<Employee>(eList,5);
		model.addAttribute("pageInfo", pageInfo);
		
		return "list";
	}
}
