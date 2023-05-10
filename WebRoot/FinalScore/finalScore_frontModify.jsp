<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.FinalScore" %>
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ page import="com.chengxusheji.po.Colleage" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的classObj信息
    List<ClassInfo> classInfoList = (List<ClassInfo>)request.getAttribute("classInfoList");
    //获取所有的colleageObj信息
    List<Colleage> colleageList = (List<Colleage>)request.getAttribute("colleageList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    FinalScore finalScore = (FinalScore)request.getAttribute("finalScore");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改综合成绩信息</TITLE>
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
  		<li class="active">综合成绩信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="finalScoreEditForm" id="finalScoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="finalScore_scoreId_edit" class="col-md-3 text-right">成绩id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="finalScore_scoreId_edit" name="finalScore.scoreId" class="form-control" placeholder="请输入成绩id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="finalScore_studentObj_studentNumber_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="finalScore_studentObj_studentNumber_edit" name="finalScore.studentObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="finalScore_colleageObj_colleageNumber_edit" class="col-md-3 text-right">学院:</label>
		  	 <div class="col-md-9">
			    <select id="finalScore_colleageObj_colleageNumber_edit" name="finalScore.colleageObj.colleageNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="finalScore_classObj_classNumber_edit" class="col-md-3 text-right">班级:</label>
		  	 <div class="col-md-9">
			    <select id="finalScore_classObj_classNumber_edit" name="finalScore.classObj.classNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="finalScore_courseFinalScore_edit" class="col-md-3 text-right">科目成绩折算分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="finalScore_courseFinalScore_edit" name="finalScore.courseFinalScore" class="form-control" placeholder="请输入科目成绩折算分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="finalScore_finalAddScore_edit" class="col-md-3 text-right">各项目加分数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="finalScore_finalAddScore_edit" name="finalScore.finalAddScore" class="form-control" placeholder="请输入各项目加分数">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="finalScore_finalScore_edit" class="col-md-3 text-right">总分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="finalScore_finalScore_edit" name="finalScore.finalScore" class="form-control" placeholder="请输入总分">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxFinalScoreModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#finalScoreEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改综合成绩界面并初始化数据*/
function finalScoreEdit(scoreId) {
	$.ajax({
		url :  basePath + "FinalScore/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (finalScore, response, status) {
			if (finalScore) {
				$("#finalScore_scoreId_edit").val(finalScore.scoreId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#finalScore_studentObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#finalScore_studentObj_studentNumber_edit").html(html);
		        		$("#finalScore_studentObj_studentNumber_edit").val(finalScore.studentObjPri);
					}
				});
				$.ajax({
					url: basePath + "Colleage/listAll",
					type: "get",
					success: function(colleages,response,status) { 
						$("#finalScore_colleageObj_colleageNumber_edit").empty();
						var html="";
		        		$(colleages).each(function(i,colleage){
		        			html += "<option value='" + colleage.colleageNumber + "'>" + colleage.colleageName + "</option>";
		        		});
		        		$("#finalScore_colleageObj_colleageNumber_edit").html(html);
		        		$("#finalScore_colleageObj_colleageNumber_edit").val(finalScore.colleageObjPri);
					}
				});
				$.ajax({
					url: basePath + "ClassInfo/listAll",
					type: "get",
					success: function(classInfos,response,status) { 
						$("#finalScore_classObj_classNumber_edit").empty();
						var html="";
		        		$(classInfos).each(function(i,classInfo){
		        			html += "<option value='" + classInfo.classNumber + "'>" + classInfo.className + "</option>";
		        		});
		        		$("#finalScore_classObj_classNumber_edit").html(html);
		        		$("#finalScore_classObj_classNumber_edit").val(finalScore.classObjPri);
					}
				});
				$("#finalScore_courseFinalScore_edit").val(finalScore.courseFinalScore);
				$("#finalScore_finalAddScore_edit").val(finalScore.finalAddScore);
				$("#finalScore_finalScore_edit").val(finalScore.finalScore);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交综合成绩信息表单给服务器端修改*/
function ajaxFinalScoreModify() {
	$.ajax({
		url :  basePath + "FinalScore/" + $("#finalScore_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#finalScoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#finalScoreQueryForm").submit();
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
    finalScoreEdit("<%=request.getParameter("scoreId")%>");
 })
 </script> 
</body>
</html>

