package com.cduestc.crud.bean;

import javax.validation.constraints.Pattern;


public class Employee {
	
    private Integer empId;
    
    @Pattern(regexp="(^[a-zA-Z0-9]{2,10}$)|(^[\u2E80-\u9FFF]{2,10})",message="用户名必须2-10位英文、数字或汉字组成")
    private String empName;

    private String empGender;
    //java不认识单斜杠"\",只能双杠"\\"
    @Pattern(regexp="^([a-zA-Z0-9]{3,10})@([\\da-z\\.-]+).([a-z]{2,6})$",message="邮箱格式不正确")
    private String empEmail;

    private Integer deptId;
    
    private Department dept;
    
    
    public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String empGender,
			String empEmail, Integer deptId) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empGender = empGender;
		this.empEmail = empEmail;
		this.deptId = deptId;
	}

	public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getEmpGender() {
        return empGender;
    }

    public void setEmpGender(String empGender) {
        this.empGender = empGender == null ? null : empGender.trim();
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail == null ? null : empEmail.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

	public Department getDept() {
		return dept;
	}

	public void setDept(Department dept) {
		this.dept = dept;
	}
    
    
}