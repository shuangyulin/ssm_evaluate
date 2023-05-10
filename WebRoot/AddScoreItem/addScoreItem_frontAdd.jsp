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
<title>加分项目添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>AddScoreItem/frontlist">加分项目列表</a></li>
			    	<li role="presentation" class="active"><a href="#addScoreItemAdd" aria-controls="addScoreItemAdd" role="tab" data-toggle="tab">添加加分项目</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="addScoreItemList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="addScoreItemAdd"> 
				      	<form class="form-horizontal" name="addScoreItemAddForm" id="addScoreItemAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="addScoreItem_itemName" class="col-md-2 text-right">加分项目名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="addScoreItem_itemName" name="addScoreItem.itemName" class="form-control" placeholder="请输入加分项目名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="addScoreItem_itemScore" class="col-md-2 text-right">加分项目分数:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="addScoreItem_itemScore" name="addScoreItem.itemScore" class="form-control" placeholder="请输入加分项目分数">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxAddScoreItemAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#addScoreItemAddForm .form-group {margin:10px;}  </style>
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
	//提交添加加分项目信息
	function ajaxAddScoreItemAdd() { 
		//提交之前先验证表单
		$("#addScoreItemAddForm").data('bootstrapValidator').validate();
		if(!$("#addScoreItemAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "AddScoreItem/add",
			dataType : "json" , 
			data: new FormData($("#addScoreItemAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#addScoreItemAddForm").find("input").val("");
					$("#addScoreItemAddForm").find("textarea").val("");
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
	//验证加分项目添加表单字段
	$('#addScoreItemAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"addScoreItem.itemName": {
				validators: {
					notEmpty: {
						message: "加分项目名称不能为空",
					}
				}
			},
			"addScoreItem.itemScore": {
				validators: {
					notEmpty: {
						message: "加分项目分数不能为空",
					},
					numeric: {
						message: "加分项目分数不正确"
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
