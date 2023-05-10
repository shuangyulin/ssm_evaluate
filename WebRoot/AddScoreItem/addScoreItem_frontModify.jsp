<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.AddScoreItem" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    AddScoreItem addScoreItem = (AddScoreItem)request.getAttribute("addScoreItem");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改加分项目信息</TITLE>
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
  		<li class="active">加分项目信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="addScoreItemEditForm" id="addScoreItemEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="addScoreItem_itemId_edit" class="col-md-3 text-right">加分项目id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="addScoreItem_itemId_edit" name="addScoreItem.itemId" class="form-control" placeholder="请输入加分项目id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="addScoreItem_itemName_edit" class="col-md-3 text-right">加分项目名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="addScoreItem_itemName_edit" name="addScoreItem.itemName" class="form-control" placeholder="请输入加分项目名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="addScoreItem_itemScore_edit" class="col-md-3 text-right">加分项目分数:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="addScoreItem_itemScore_edit" name="addScoreItem.itemScore" class="form-control" placeholder="请输入加分项目分数">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxAddScoreItemModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#addScoreItemEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改加分项目界面并初始化数据*/
function addScoreItemEdit(itemId) {
	$.ajax({
		url :  basePath + "AddScoreItem/" + itemId + "/update",
		type : "get",
		dataType: "json",
		success : function (addScoreItem, response, status) {
			if (addScoreItem) {
				$("#addScoreItem_itemId_edit").val(addScoreItem.itemId);
				$("#addScoreItem_itemName_edit").val(addScoreItem.itemName);
				$("#addScoreItem_itemScore_edit").val(addScoreItem.itemScore);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交加分项目信息表单给服务器端修改*/
function ajaxAddScoreItemModify() {
	$.ajax({
		url :  basePath + "AddScoreItem/" + $("#addScoreItem_itemId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#addScoreItemEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                location.href= basePath + "AddScoreItem/frontlist";
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
    addScoreItemEdit("<%=request.getParameter("itemId")%>");
 })
 </script> 
</body>
</html>

