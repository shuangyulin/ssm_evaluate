<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Course" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Course course = (Course)request.getAttribute("course");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改课程信息信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">课程信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="courseEditForm" id="courseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="course_courseNo_edit" class="col-md-3 text-right">课程编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="course_courseNo_edit" name="course.courseNo" class="form-control" placeholder="请输入课程编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="course_courseName_edit" class="col-md-3 text-right">课程名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseName_edit" name="course.courseName" class="form-control" placeholder="请输入课程名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_courseType_edit" class="col-md-3 text-right">课程类型:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseType_edit" name="course.courseType" class="form-control" placeholder="请输入课程类型">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_courseScore_edit" class="col-md-3 text-right">课程学分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseScore_edit" name="course.courseScore" class="form-control" placeholder="请输入课程学分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_teacherName_edit" class="col-md-3 text-right">上课老师:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_teacherName_edit" name="course.teacherName" class="form-control" placeholder="请输入上课老师">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_courseHour_edit" class="col-md-3 text-right">课程总学时:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseHour_edit" name="course.courseHour" class="form-control" placeholder="请输入课程总学时">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCourseModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#courseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改课程信息界面并初始化数据*/
function courseEdit(courseNo) {
	$.ajax({
		url :  basePath + "Course/" + courseNo + "/update",
		type : "get",
		dataType: "json",
		success : function (course, response, status) {
			if (course) {
				$("#course_courseNo_edit").val(course.courseNo);
				$("#course_courseName_edit").val(course.courseName);
				$("#course_courseType_edit").val(course.courseType);
				$("#course_courseScore_edit").val(course.courseScore);
				$("#course_teacherName_edit").val(course.teacherName);
				$("#course_courseHour_edit").val(course.courseHour);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交课程信息信息表单给服务器端修改*/
function ajaxCourseModify() {
	$.ajax({
		url :  basePath + "Course/" + $("#course_courseNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#courseQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    courseEdit("<%=request.getParameter("courseNo")%>");
 })
 </script> 
</body>
</html>

