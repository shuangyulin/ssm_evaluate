<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>课程成绩添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>CourseScore/frontlist">课程成绩列表</a></li>
			    	<li role="presentation" class="active"><a href="#courseScoreAdd" aria-controls="courseScoreAdd" role="tab" data-toggle="tab">添加课程成绩</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="courseScoreList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="courseScoreAdd"> 
				      	<form class="form-horizontal" name="courseScoreAddForm" id="courseScoreAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="courseScore_studentObj_studentNumber" class="col-md-2 text-right">学生:</label>
						  	 <div class="col-md-8">
							    <select id="courseScore_studentObj_studentNumber" name="courseScore.studentObj.studentNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="courseScore_courseObj_courseNo" class="col-md-2 text-right">课程:</label>
						  	 <div class="col-md-8">
							    <select id="courseScore_courseObj_courseNo" name="courseScore.courseObj.courseNo" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="courseScore_score" class="col-md-2 text-right">成绩:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="courseScore_score" name="courseScore.score" class="form-control" placeholder="请输入成绩">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxCourseScoreAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#courseScoreAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加课程成绩信息
	function ajaxCourseScoreAdd() { 
		//提交之前先验证表单
		$("#courseScoreAddForm").data('bootstrapValidator').validate();
		if(!$("#courseScoreAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "CourseScore/add",
			dataType : "json" , 
			data: new FormData($("#courseScoreAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#courseScoreAddForm").find("input").val("");
					$("#courseScoreAddForm").find("textarea").val("");
				} else {
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
	//验证课程成绩添加表单字段
	$('#courseScoreAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"courseScore.score": {
				validators: {
					notEmpty: {
						message: "成绩不能为空",
					},
					numeric: {
						message: "成绩不正确"
					}
				}
			},
		}
	}); 
	//初始化学生下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#courseScore_studentObj_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
    		});
    		$("#courseScore_studentObj_studentNumber").html(html);
    	}
	});
	//初始化课程下拉框值 
	$.ajax({
		url: basePath + "Course/listAll",
		type: "get",
		success: function(courses,response,status) { 
			$("#courseScore_courseObj_courseNo").empty();
			var html="";
    		$(courses).each(function(i,course){
    			html += "<option value='" + course.courseNo + "'>" + course.courseName + "</option>";
    		});
    		$("#courseScore_courseObj_courseNo").html(html);
    	}
	});
})
</script>
</body>
</html>
