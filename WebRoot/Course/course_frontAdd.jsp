<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>课程信息添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Course/frontlist">课程信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#courseAdd" aria-controls="courseAdd" role="tab" data-toggle="tab">添加课程信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="courseList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="courseAdd"> 
				      	<form class="form-horizontal" name="courseAddForm" id="courseAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
							 <label for="course_courseNo" class="col-md-2 text-right">课程编号:</label>
							 <div class="col-md-8"> 
							 	<input type="text" id="course_courseNo" name="course.courseNo" class="form-control" placeholder="请输入课程编号">
							 </div>
						  </div> 
						  <div class="form-group">
						  	 <label for="course_courseName" class="col-md-2 text-right">课程名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="course_courseName" name="course.courseName" class="form-control" placeholder="请输入课程名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="course_courseType" class="col-md-2 text-right">课程类型:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="course_courseType" name="course.courseType" class="form-control" placeholder="请输入课程类型">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="course_courseScore" class="col-md-2 text-right">课程学分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="course_courseScore" name="course.courseScore" class="form-control" placeholder="请输入课程学分">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="course_teacherName" class="col-md-2 text-right">上课老师:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="course_teacherName" name="course.teacherName" class="form-control" placeholder="请输入上课老师">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="course_courseHour" class="col-md-2 text-right">课程总学时:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="course_courseHour" name="course.courseHour" class="form-control" placeholder="请输入课程总学时">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxCourseAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#courseAddForm .form-group {margin:10px;}  </style>
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
	//提交添加课程信息信息
	function ajaxCourseAdd() { 
		//提交之前先验证表单
		$("#courseAddForm").data('bootstrapValidator').validate();
		if(!$("#courseAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Course/add",
			dataType : "json" , 
			data: new FormData($("#courseAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#courseAddForm").find("input").val("");
					$("#courseAddForm").find("textarea").val("");
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
	//验证课程信息添加表单字段
	$('#courseAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"course.courseNo": {
				validators: {
					notEmpty: {
						message: "课程编号不能为空",
					}
				}
			},
			"course.courseName": {
				validators: {
					notEmpty: {
						message: "课程名称不能为空",
					}
				}
			},
			"course.courseType": {
				validators: {
					notEmpty: {
						message: "课程类型不能为空",
					}
				}
			},
			"course.courseScore": {
				validators: {
					notEmpty: {
						message: "课程学分不能为空",
					},
					numeric: {
						message: "课程学分不正确"
					}
				}
			},
			"course.teacherName": {
				validators: {
					notEmpty: {
						message: "上课老师不能为空",
					}
				}
			},
			"course.courseHour": {
				validators: {
					notEmpty: {
						message: "课程总学时不能为空",
					},
					integer: {
						message: "课程总学时不正确"
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
