<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseScore" %>
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的courseObj信息
    List<Course> courseList = (List<Course>)request.getAttribute("courseList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    CourseScore courseScore = (CourseScore)request.getAttribute("courseScore");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改课程成绩信息</TITLE>
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
  		<li class="active">课程成绩信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="courseScoreEditForm" id="courseScoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="courseScore_scoreId_edit" class="col-md-3 text-right">成绩id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="courseScore_scoreId_edit" name="courseScore.scoreId" class="form-control" placeholder="请输入成绩id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="courseScore_studentObj_studentNumber_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="courseScore_studentObj_studentNumber_edit" name="courseScore.studentObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseScore_courseObj_courseNo_edit" class="col-md-3 text-right">课程:</label>
		  	 <div class="col-md-9">
			    <select id="courseScore_courseObj_courseNo_edit" name="courseScore.courseObj.courseNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseScore_score_edit" class="col-md-3 text-right">成绩:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseScore_score_edit" name="courseScore.score" class="form-control" placeholder="请输入成绩">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxCourseScoreModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#courseScoreEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改课程成绩界面并初始化数据*/
function courseScoreEdit(scoreId) {
	$.ajax({
		url :  basePath + "CourseScore/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (courseScore, response, status) {
			if (courseScore) {
				$("#courseScore_scoreId_edit").val(courseScore.scoreId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#courseScore_studentObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#courseScore_studentObj_studentNumber_edit").html(html);
		        		$("#courseScore_studentObj_studentNumber_edit").val(courseScore.studentObjPri);
					}
				});
				$.ajax({
					url: basePath + "Course/listAll",
					type: "get",
					success: function(courses,response,status) { 
						$("#courseScore_courseObj_courseNo_edit").empty();
						var html="";
		        		$(courses).each(function(i,course){
		        			html += "<option value='" + course.courseNo + "'>" + course.courseName + "</option>";
		        		});
		        		$("#courseScore_courseObj_courseNo_edit").html(html);
		        		$("#courseScore_courseObj_courseNo_edit").val(courseScore.courseObjPri);
					}
				});
				$("#courseScore_score_edit").val(courseScore.score);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交课程成绩信息表单给服务器端修改*/
function ajaxCourseScoreModify() {
	$.ajax({
		url :  basePath + "CourseScore/" + $("#courseScore_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseScoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#courseScoreQueryForm").submit();
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
    courseScoreEdit("<%=request.getParameter("scoreId")%>");
 })
 </script> 
</body>
</html>

