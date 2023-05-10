<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ page import="com.chengxusheji.po.Colleage" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的colleageObj信息
    List<Colleage> colleageList = (List<Colleage>)request.getAttribute("colleageList");
    ClassInfo classInfo = (ClassInfo)request.getAttribute("classInfo");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改班级信息信息</TITLE>
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
  		<li class="active">班级信息信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="classInfoEditForm" id="classInfoEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="classInfo_classNumber_edit" class="col-md-3 text-right">班级编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="classInfo_classNumber_edit" name="classInfo.classNumber" class="form-control" placeholder="请输入班级编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="classInfo_className_edit" class="col-md-3 text-right">班级名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="classInfo_className_edit" name="classInfo.className" class="form-control" placeholder="请输入班级名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_colleageObj_colleageNumber_edit" class="col-md-3 text-right">所在学院:</label>
		  	 <div class="col-md-9">
			    <select id="classInfo_colleageObj_colleageNumber_edit" name="classInfo.colleageObj.colleageNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_banzhuren_edit" class="col-md-3 text-right">班主任:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="classInfo_banzhuren_edit" name="classInfo.banzhuren" class="form-control" placeholder="请输入班主任">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="classInfo_startDate_edit" class="col-md-3 text-right">开办日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date classInfo_startDate_edit col-md-12" data-link-field="classInfo_startDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="classInfo_startDate_edit" name="classInfo.startDate" size="16" type="text" value="" placeholder="请选择开办日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxClassInfoModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#classInfoEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改班级信息界面并初始化数据*/
function classInfoEdit(classNumber) {
	$.ajax({
		url :  basePath + "ClassInfo/" + classNumber + "/update",
		type : "get",
		dataType: "json",
		success : function (classInfo, response, status) {
			if (classInfo) {
				$("#classInfo_classNumber_edit").val(classInfo.classNumber);
				$("#classInfo_className_edit").val(classInfo.className);
				$.ajax({
					url: basePath + "Colleage/listAll",
					type: "get",
					success: function(colleages,response,status) { 
						$("#classInfo_colleageObj_colleageNumber_edit").empty();
						var html="";
		        		$(colleages).each(function(i,colleage){
		        			html += "<option value='" + colleage.colleageNumber + "'>" + colleage.colleageName + "</option>";
		        		});
		        		$("#classInfo_colleageObj_colleageNumber_edit").html(html);
		        		$("#classInfo_colleageObj_colleageNumber_edit").val(classInfo.colleageObjPri);
					}
				});
				$("#classInfo_banzhuren_edit").val(classInfo.banzhuren);
				$("#classInfo_startDate_edit").val(classInfo.startDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交班级信息信息表单给服务器端修改*/
function ajaxClassInfoModify() {
	$.ajax({
		url :  basePath + "ClassInfo/" + $("#classInfo_classNumber_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#classInfoEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#classInfoQueryForm").submit();
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
    /*开办日期组件*/
    $('.classInfo_startDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    classInfoEdit("<%=request.getParameter("classNumber")%>");
 })
 </script> 
</body>
</html>

