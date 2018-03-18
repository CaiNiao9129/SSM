<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
pageContext.setAttribute("APP_PATH",request.getContextPath());
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>员工列表</title>
    <!-- WEB路径问题
    	不以/开始的相对路径，找资源，以当前资源的路径为基准，会经常出问题，所以不建议使用
    	以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306/ssm-crud)绝对路径
    	 -->
    <!--引入jQuery  -->
    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <!--引入样式  -->
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
  	<script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
  </head>
  
  <body>
  	<!--员工添加 模态框 -->
	  	<div class="modal fade" id="addempModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
		        
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Name</label>
				    <div class="col-sm-10">
				      <input type="text" name="empName" class="form-control" id="input_empName" placeholder="empName">
				      <span class="help-block"></span>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Gender</label>
				    <div class="col-sm-10">
				    	<label class="radio-inline">
						  <input type="radio" name="empGender"id="gender1_add_input" value="M" checked="checked"> 男
							
						</label>
						<label class="radio-inline">
						  <input type="radio" name="empGender" id="gender2_add_input" value="F"> 女
				</label>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-10">
				      <input type="text" name="empEmail" class="form-control" id="input_empEmail" placeholder="Email@qq.com">
				    	  <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">DeptName</label>
				    <div class="col-sm-3">
						 <select class="form-control" name="deptId" id="select_dept">
						  
						</select>
				    </div>
				  </div>
				  
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="save_emp_btn">保存</button>
		      </div>
		    </div>
		  </div>
	</div> 
	<!-- 员工修改模态框 -->
	<div class="modal fade" id="updateempModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="exampleModalLabel">New message</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
		        
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Name</label>
				    <div class="col-sm-10">
				      <p class="form-control-static" id="update_empName" placeholder="empName"></p>
				      <span class="help-block"></span>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Gender</label>
				    <div class="col-sm-10">
				    	<label class="radio-inline">
						  <input type="radio" name="empGender"id="gender1_add_input" value="M" checked="checked"> 男
							
						</label>
						<label class="radio-inline">
						  <input type="radio" name="empGender" id="gender2_add_input" value="F"> 女
				</label>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <label class="col-sm-2 control-label">Email</label>
				    <div class="col-sm-10">
				      <input type="text" name="empEmail" class="form-control" id="update_empEmail" placeholder="Email@qq.com">
				    	  <span class="help-block"></span>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-2 control-label">DeptName</label>
				    <div class="col-sm-3">
						 <select class="form-control" name="deptId" id="update_dept">
						  
						</select>
				    </div>
				  </div>
				  
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
		        <button type="button" class="btn btn-primary" id="update_emp_btn">更新</button>
		      </div>
		    </div>
		  </div>
	</div>   	  	
	<!--搭建显示页面  -->
   	<div class="container">
   		<!--标题  -->
   		<div class="row">
   			<div class="col-md-12">
   				<h1>SSM-CRUD</h1>
   			</div>
   		</div>
   		<!-- 按钮  col-md-offset-8 偏移8列-->
   		<div class="row">
   			<div class="col-md-4 col-md-offset-8">
   				<button class="btn btn-primary" id="add_emp_Modal_btn">新增</button>
   				<button class="btn btn-danger" id="delete_more_emp_btn">删除</button>
   			</div>
   		</div>
   		<!--表格  -->
   		<div class="row">
   			<div class="col-md-12">
   				<table class="table table-hover" id="emps_table">
   					<thead>
	   					<tr>
	   						<th>
	   						<input type="checkbox" id="check_emp"/>
	   						</th>
	   						<th>#</th>
	   						<th>姓名</th>
	   						<th>性别</th>
	   						<th>邮箱</th>
	   						<th>部门</th>
	   						<th>操作</th>
	   					</tr>
   					</thead>
   					<tbody>
   					
   					
   					</tbody>
   				</table>
   			</div>
   		</div>
   		<!-- 分页 -->
   		<div class="row">
   			<!-- 分页文字信息 -->
   			<div class="col-md-6" id="page_info_area">
   				
   			</div>
   			<!--  分页条信息-->
	   			<div class="col-md-12" id="page_nav_area">
	   				
	   			</div>
   		</div>
   	</div>
  	<!-- 新增员工操作(添加，校验等等) -->
  	<script type="text/javascript">
   		//建立一个总记录数
   		var totalRecord;
   		var inPageNum;
   		$(function(){
   			to_page(1);
   		});
   		
	   	//页面跳转
	   	function to_page(page){
	   		$.ajax({
	   			url:"${APP_PATH}/Employee/getAllEmps",
	   			data:"page="+page,
	   			type:"GET",
	   			success:function(result){
	   				//显示员工信息
	   				build_emps_table(result);
	   				//显示分页信息
	   				build_page_Info(result);
	   				//显示分页条信息
	   				build_page_nav(result);
	   			}
	   		});
	   	}
	   	
	   	function build_emps_table(result){
	   		//清空之前的数据
	   		$("#emps_table tbody").empty();
				var emps = result.extend.pageInfo.list;
				$.each(emps,function(index,item){
					var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
					var empIdTd = $("<td></td>").append(item.empId);
					var empNameTd = $("<td></td>").append(item.empName);
					var empGenderTd = $("<td></td>").append(item.empGender=='M'?"男":"女");
					var empEmailTd = $("<td></td>").append(item.empEmail);
					var deptNameTd = $("<td></td>").append(item.dept.deptName);
					/* 
					<button class="btn btn-primary btn-sm">
	   								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
	   								编辑
	   							</button>
	   							<button class="btn btn-danger btn-sm">
	   								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
	   								删除
	   							</button>
					 */
					var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append("<span></span>").addClass("glyphicon glyphicon-pencil")
								.append(" 编辑");
					editBtn.attr("edit-id",item.empId);
					var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn")
								.append("<span></span>").addClass("glyphicon glyphicon-trash")
								.append(" 删除");
					delBtn.attr("del-id",item.empId);
					$("<tr></tr>").append(checkBoxTd)
						.append(empIdTd)
						.append(empNameTd)
						.append(empGenderTd)
						.append(empEmailTd)
						.append(deptNameTd)
						.append(editBtn)
						.append(delBtn)
						.appendTo("#emps_table tbody");
				});
			}
			
			function build_page_Info(result){
				$("#page_info_area").empty();
				
					$("#page_info_area").append("当前第 "+ result.extend.pageInfo.pageNum +" 页 || 一共 "+ result.extend.pageInfo.pages +" 页 || 总共 "+ result.extend.pageInfo.total + " 条记录"),
					
					totalRecord = result.extend.pageInfo.total;
					inPageNum = result.extend.pageInfo.pageNum;
			}
			
			
			function build_page_nav(result){
			
				$("#page_nav_area").empty();
				
				var ul = $("<ul></ul>").addClass("pagination");
				var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
					
				var prevPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&laquo;")));
				if(result.extend.pageInfo.hasPreviousPage == false){
					firstPageLi.addClass("disabled");
					prevPageLi.addClass("disabled");
				}else{
					firstPageLi.click(function(){
						to_page(1);
					});
					prevPageLi.click(function(){
						to_page(result.extend.pageInfo.pageNum - 1);
					});
				
				}
				var nextPageLi = $("<li></li>").append($("<a></a>").append($("<span></span>").append("&raquo;")));
				var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
				if(result.extend.pageInfo.hasNextPage == false){
					nextPageLi.addClass("disabled");
					lastPageLi.addClass("disabled");
				}else{
				//点击添加翻页的事件
					nextPageLi.click(function(){
						to_page(result.extend.pageInfo.pageNum + 1);
					});
					lastPageLi.click(function(){
						to_page(result.extend.pageInfo.pages);
					});
				}
				
				ul.append(firstPageLi).append(prevPageLi);
				$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
					var numLi =  $("<li></li>").append($("<a></a>").append(item));
					if(result.extend.pageInfo.pageNum == item){
						numLi.addClass("active");
					}
					numLi.click(function(){
						to_page(item);
					});
					ul.append(numLi);
				});
				ul.append(nextPageLi).append(lastPageLi);
				//层层包含
				var navEle = $("<nav></nav>").append(ul);
				navEle.appendTo("#page_nav_area");
			}
	</script>
	
	<script type="text/javascript">
			/*  
				员工添加事件			
			*/
			$("#add_emp_Modal_btn").click(function(){
				//清除表单数据
				reset_form("#addempModal form");
				
				getDeptName("#select_dept");
				$("#addempModal").modal({
					backdrop:"static"
				});
			});
			
			//员工新增选择部门
			function getDeptName(ele){
				$(ele).empty();
				$.ajax({
					url:"${APP_PATH}/Dept/getDept",
					type:"GET",
					success:function(result){
						//console.log(result)
						//显示部门信息
						$.each(result.extend.depts,function(){
							var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
								optionEle.appendTo(ele);
							});
					}
				});
			}
			
			//保存信息
			$("#save_emp_btn").click(function(){
				//数据校验
				 if(!validate_add_form()){
					return false;
				};  
				//判断每一项校验是否成功
				if($(this).attr("ajax-va")=="error"){
					show_validate_msg("#input_empName","error","用户名不可用");
					return false;
				}
				
				$.ajax({
					url:"${APP_PATH}/Employee/saveEmp",
					type:"POST",
					//将表单中内容拿出
					data:$("#addempModal form").serialize(),
					success:function(result){
						if(result.code == 100){
							$("#addempModal").modal("hide");
							to_page(totalRecord);
						}else{
							if(undefined != result.extend.errorFields.empEmail){
								show_validate_msg("#input_empEmail","error",result.extend.errorFields.empEmail);
							}
							if(undefined != result.extend.errorFields.empName)
								show_validate_msg("#input_empName","error",result.extend.errorFields.empName);
						}
					}
				});
			});
			
			//校验表单数据
			function validate_add_form(){
				var empName = $("#input_empName").val();
				var regName = /(^[a-zA-Z0-9]{2,10}$)|(^[\u2E80-\u9FFF]{2,10})/;
				if(regName.test(empName) == false){
					show_validate_msg("#input_empName","error","用户名必须2-10位英文、数字或汉字组成");
					$("#save_emp_btn").attr("ajax-va","error3");
					return false;
				}else{
					show_validate_msg("#input_empName","success","");
				}
				//校验邮箱 
				var empEmail = $("#input_empEmail").val();
				var regEmail = /^([a-zA-Z0-9]{3,10})@([\da-z\.-]+).([a-z]{2,6})$/;
				if(regEmail.test(empEmail) == false){
					show_validate_msg("#input_empEmail","error","邮箱格式不正确");
					$("#save_emp_btn").attr("ajax-va","error2");
					return false;
				}else{
					show_validate_msg("#input_empEmail","success","");
				}
				return true;
			}
			
			//显示校验信息
			function show_validate_msg(ele,status,msg){
				
				$(ele).parent().removeClass("has-success");
				$(ele).parent().removeClass("has-error");
				$(ele).next("span").text("");
				if("success" == status){
					$(ele).parent().addClass("has-success");
					$(ele).next("span").text(msg);
				
				}else if("error" == status){
					$(ele).parent().addClass("has-error");
					$(ele).next("span").text(msg);
				}
			}
			//校验用户名是否重复
			$("#input_empName").change(function(){
				var empName = this.value;
				$.ajax({
					url:"${APP_PATH}/Employee/checkEmp",
					data:"empName="+empName,
					type:"POST",
					success:function(result){
						if(result.code == 100){
							show_validate_msg("#input_empName","success","用户名可用");
							$("#save_emp_btn").attr("ajax-va","success");
						}else{
							show_validate_msg("#input_empName","error",result.extend.va_msg);
							$("#save_emp_btn").attr("ajax-va","error");
						}
					}
				});
			});
			//表单完全重置方法
			function reset_form(ele){
				$(ele)[0].reset();
				//清除表单样式
				$(ele).find("*").removeClass("has-success has-error");
				$(ele).find(".help-block").text("");
			};
			
   	</script>
  	<!-- 员工更新操作 -->
  	<script type="text/javascript">
  		$(document).on("click",".edit_btn",function(){
  			getDeptName("#update_dept");
  			getEmp($(this).attr("edit-id"));
  			$("#update_emp_btn").attr("update-empId",$(this).attr("edit-id"));
  			//查出员工信息
  			$("#updateempModal").modal({
  				backdrop:"static"
  			});
  		});
  		
  		function getEmp(empId){
  			$.ajax({
  				url:"${APP_PATH}/Employee/getEmp/"+empId,
  				type:"GET",
  				success: function(result){
  					
  					var empData = result.extend.emp;
  					$("#update_empName").text(empData.empName);
  					$("#update_empEmail").val(empData.empEmail);
  					$("#updateempModal input[name=empGender]").val([empData.empGender]);
  					$("#updateempModal select").val([empData.deptId]);
  					
  				}
  				
  			});
  		};
  		//点击更新
  		$("#update_emp_btn").click(function(){
  			var empEmail = $("#update_empEmail").val();
				var regEmail = /^([a-zA-Z0-9]{3,10})@([\da-z\.-]+).([a-z]{2,6})$/;
				if(regEmail.test(empEmail) == false){
					show_validate_msg("#update_empEmail","error","邮箱格式不正确");
					$("#save_emp_btn").attr("ajax-va","error2");
					return false;
				}else{
					show_validate_msg("#update_empEmail","success","");
				}
  			//2:发送ajax请求保存更新
  			$.ajax({
  				url:"${APP_PATH}/Employee/saveEmp/"+$(this).attr("update-empId"),
  				type:"POST",//过滤器会自动把post请求转换为put请求和delete
  				data:$("#updateempModal form").serialize()+"&_method=PUT",
  				success:function(result){
  					$("#updateempModal").modal("hide");
					to_page(inPageNum);
  					alert("更新成功");
  				}
  			});
 		});
 		/* 删除员工 */
		$(document).on("click",".del_btn",function(){
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if(confirm("确认删除 "+ empName +" 吗?")){
				
				$.ajax({
					url:"${APP_PATH}/Employee/deleteEmp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(inPageNum);
  						alert("删除成功");
					}
				});
			};
		});
		
		//选择员工
		$("#check_emp").click(function(){
			
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否是7个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_emp").prop("checked",flag);
		});
		//多个员工删除
		$("#delete_more_emp_btn").click(function(){
			$("#check_emp").empty();
			var empNames =" ";
			var del_ids = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+ " ";
				del_ids  += $(this).parents("tr").find("td:eq(1)").text()+ "-";
				
			});
			empNames = empNames.substring(0, empNames.length -1);
			del_ids  = del_ids.substring(0, del_ids.length -1);
			if(confirm("确认删除 " + empNames + " 吗？")){
				$.ajax({
					url:"${APP_PATH}/Employee//deleteEmp/"+del_ids,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(inPageNum);
					}
				});
			}
		});
		
  	</script>
  </body>
</html>
