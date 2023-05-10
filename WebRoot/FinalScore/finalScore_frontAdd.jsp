<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ page import="com.chengxusheji.po.Colleage" %>
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
<title>综合成绩添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>FinalScore/frontlist">综合成绩列表</a></li>
			    	<li role="presentation" class="active"><a href="#finalScoreAdd" aria-controls="finalScoreAdd" role="tab" data-toggle="tab">添加综合成绩</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="finalScoreList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="finalScoreAdd"> 
				      	<form class="form-horizontal" name="finalScoreAddForm" id="finalScoreAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="finalScore_studentObj_studentNumber" class="col-md-2 text-right">学生:</label>
						  	 <div class="col-md-8">
							    <select id="finalScore_studentObj_studentNumber" name="finalScore.studentObj.studentNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="finalScore_colleageObj_colleageNumber" class="col-md-2 text-right">学院:</label>
						  	 <div class="col-md-8">
							    <select id="finalScore_colleageObj_colleageNumber" name="finalScore.colleageObj.colleageNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="finalScore_classObj_classNumber" class="col-md-2 text-right">班级:</label>
						  	 <div class="col-md-8">
							    <select id="finalScore_classObj_classNumber" name="finalScore.classObj.classNumber" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="finalScore_courseFinalScore" class="col-md-2 text-right">科目成绩折算分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="finalScore_courseFinalScore" name="finalScore.courseFinalScore" class="form-control" placeholder="请输入科目成绩折算分">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="finalScore_finalAddScore" class="col-md-2 text-right">各项目加分数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="finalScore_finalAddScore" name="finalScore.finalAddScore" class="form-control" placeholder="请输入各项目加分数">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="finalScore_finalScore" class="col-md-2 text-right">总分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="finalScore_finalScore" name="finalScore.finalScore" class="form-control" placeholder="请输入总分">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxFinalScoreAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#finalScoreAddForm .form-group {margin:10px;}  </style>
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
	//提交添加综合成绩信息
	function ajaxFinalScoreAdd() { 
		//提交之前先验证表单
		$("#finalScoreAddForm").data('bootstrapValidator').validate();
		if(!$("#finalScoreAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "FinalScore/add",
			dataType : "json" , 
			data: new FormData($("#finalScoreAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#finalScoreAddForm").find("input").val("");
					$("#finalScoreAddForm").find("textarea").val("");
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
	//验证综合成绩添加表单字段
	$('#finalScoreAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"finalScore.courseFinalScore": {
				validators: {
					notEmpty: {
						message: "科目成绩折算分不能为空",
					},
					numeric: {
						message: "科目成绩折算分不正确"
					}
				}
			},
			"finalScore.finalAddScore": {
				validators: {
					notEmpty: {
						message: "各项目加分数不能为空",
					},
					numeric: {
						message: "各项目加分数不正确"
					}
				}
			},
			"finalScore.finalScore": {
				validators: {
					notEmpty: {
						message: "总分不能为空",
					},
					numeric: {
						message: "总分不正确"
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
			$("#finalScore_studentObj_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
    		});
    		$("#finalScore_studentObj_studentNumber").html(html);
    	}
	});
	//初始化学院下拉框值 
	$.ajax({
		url: basePath + "Colleage/listAll",
		type: "get",
		success: function(colleages,response,status) { 
			$("#finalScore_colleageObj_colleageNumber").empty();
			var html="";
    		$(colleages).each(function(i,colleage){
    			html += "<option value='" + colleage.colleageNumber + "'>" + colleage.colleageName + "</option>";
    		});
    		$("#finalScore_colleageObj_colleageNumber").html(html);
    	}
	});
	//初始化班级下拉框值 
	$.ajax({
		url: basePath + "ClassInfo/listAll",
		type: "get",
		success: function(classInfos,response,status) { 
			$("#finalScore_classObj_classNumber").empty();
			var html="";
    		$(classInfos).each(function(i,classInfo){
    			html += "<option value='" + classInfo.classNumber + "'>" + classInfo.className + "</option>";
    		});
    		$("#finalScore_classObj_classNumber").html(html);
    	}
	});
})
</script>
</body>
</html>
