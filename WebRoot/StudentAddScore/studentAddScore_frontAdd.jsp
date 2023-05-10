<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.AddScoreItem" %>
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
<title>学生加分添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>StudentAddScore/frontlist">学生加分管理</a></li>
  			<li class="active">添加学生加分</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="studentAddScoreAddForm" id="studentAddScoreAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="studentAddScore_studenObj_studentNumber" class="col-md-2 text-right">学生:</label>
				  	 <div class="col-md-8">
					    <select id="studentAddScore_studenObj_studentNumber" name="studentAddScore.studenObj.studentNumber" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="studentAddScore_addScoreObj_itemId" class="col-md-2 text-right">加分项目:</label>
				  	 <div class="col-md-8">
					    <select id="studentAddScore_addScoreObj_itemId" name="studentAddScore.addScoreObj.itemId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="studentAddScore_proof" class="col-md-2 text-right">证明材料:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="studentAddScore_proofImg" border="0px"/><br/>
					    <input type="hidden" id="studentAddScore_proof" name="studentAddScore.proof"/>
					    <input id="proofFile" name="proofFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="studentAddScore_shengQingShiJian" class="col-md-2 text-right">申请时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="studentAddScore_shengQingShiJian" name="studentAddScore.shengQingShiJian" class="form-control" placeholder="请输入申请时间">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="studentAddScore_shenHeState" class="col-md-2 text-right">审核状态:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="studentAddScore_shenHeState" name="studentAddScore.shenHeState" class="form-control" placeholder="请输入审核状态">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="studentAddScore_shenHeTime" class="col-md-2 text-right">审核时间:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="studentAddScore_shenHeTime" name="studentAddScore.shenHeTime" class="form-control" placeholder="请输入审核时间">
					 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxStudentAddScoreAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#studentAddScoreAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
	//提交添加学生加分信息
	function ajaxStudentAddScoreAdd() { 
		//提交之前先验证表单
		$("#studentAddScoreAddForm").data('bootstrapValidator').validate();
		if(!$("#studentAddScoreAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "StudentAddScore/add",
			dataType : "json" , 
			data: new FormData($("#studentAddScoreAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#studentAddScoreAddForm").find("input").val("");
					$("#studentAddScoreAddForm").find("textarea").val("");
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
	//验证学生加分添加表单字段
	$('#studentAddScoreAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"studentAddScore.shenHeState": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
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
			$("#studentAddScore_studenObj_studentNumber").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
    		});
    		$("#studentAddScore_studenObj_studentNumber").html(html);
    	}
	});
	//初始化加分项目下拉框值 
	$.ajax({
		url: basePath + "AddScoreItem/listAll",
		type: "get",
		success: function(addScoreItems,response,status) { 
			$("#studentAddScore_addScoreObj_itemId").empty();
			var html="";
    		$(addScoreItems).each(function(i,addScoreItem){
    			html += "<option value='" + addScoreItem.itemId + "'>" + addScoreItem.itemName + "</option>";
    		});
    		$("#studentAddScore_addScoreObj_itemId").html(html);
    	}
	});
})
</script>
</body>
</html>
