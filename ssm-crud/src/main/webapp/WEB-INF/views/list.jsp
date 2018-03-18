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
  	<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"></script>  
  </head>
  
  <body>
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
   				<button class="btn btn-primary">新增</button>
   				<button class="btn btn-danger">删除</button>
   			</div>
   		</div>
   		<!--表格  -->
   		<div class="row">
   			<div class="col-md-12">
   				<table class="table table-hover">
   					<tr>
   						<th>#</th>
   						<th>姓名</th>
   						<th>邮箱</th>
   						<th>性别</th>
   						<th>部门</th>
   						<th>操作</th>
   					</tr>
   					<c:forEach items="${pageInfo.list }" var="emp">
	   					<tr>
	   						<th>${emp.empId }</th>
	   						<th>${emp.empName }</th>
	   						<th>${emp.empEmail }</th>
	   						<th>${emp.empGender=="M"?"男":"女" }</th>
	   						<th>${emp.dept.deptName }</th>
	   						<th>
	   							<button class="btn btn-primary btn-sm">
	   								<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
	   								编辑
	   							</button>
	   							<button class="btn btn-danger btn-sm">
	   								<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
	   								删除
	   							</button>
	   						</th>
	   					</tr>
   					</c:forEach>
   				</table>
   			</div>
   		</div>
   		<!-- 分页 -->
   		<div class="row">
   			<!-- 分页文字信息 -->
   			<div class="col-md-6">
   				当前第 ${pageInfo.pageNum } 页 || 一共 ${pageInfo.pages } 页 || 总共 ${pageInfo.total } 条记录
   			</div>
   			<!--  分页条信息-->
	   			<div class="col-md-12">
	   				<nav aria-label="Page navigation">
					  <ul class="pagination">
					  	<li><a href="${APP_PATH }/Employee/getAllEmps?page=1">首页</a>
					    <li>
					    	<c:if test="${pageInfo.hasPreviousPage }">
							      <a href="${APP_PATH }/Employee/getAllEmps?page=${pageInfo.pageNum - 1}" aria-label="Previous">
							        <span aria-hidden="true">&laquo;</span>
							      </a>
						     </c:if>
					    </li>
					    <c:forEach items="${pageInfo.navigatepageNums }" var="pageNum">
					    	<c:if test="${pageInfo.pageNum == pageNum}">
					   	 		<li class="active"><a href="#">${pageNum }</a></li>
					   	 	</c:if>
					   	 	<c:if test="${pageInfo.pageNum != pageNum}">
					   	 		<li><a href="${APP_PATH }/Employee/getAllEmps?page=${pageNum}">${pageNum }</a></li>
					   	 	</c:if>
					    </c:forEach>
						 <li>
						    <c:if test="${pageInfo.hasNextPage }">
						      <a href="${APP_PATH }/Employee/getAllEmps?page=${pageInfo.pageNum + 1}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						   </c:if>
					    </li>
					    <li><a href="${APP_PATH }/Employee/getAllEmps?page=${pageInfo.pages}">
					    	末页
					    	</a>
					    </li>
					  </ul>
					</nav>
	   			</div>
   		</div>
   		
   	</div>
  </body>
</html>
