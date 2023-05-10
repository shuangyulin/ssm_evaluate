<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.StudentAddScore" %>
<%@ page import="com.chengxusheji.po.AddScoreItem" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的addScoreObj信息
    List<AddScoreItem> addScoreItemList = (List<AddScoreItem>)request.getAttribute("addScoreItemList");
    //获取所有的studenObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    StudentAddScore studentAddScore = (StudentAddScore)request.getAttribute("studentAddScore");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改学生加分信息</TITLE>
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
  		<li class="active">学生加分信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="studentAddScoreEditForm" id="studentAddScoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="studentAddScore_addScoreId_edit" class="col-md-3 text-right">加分id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="studentAddScore_addScoreId_edit" name="studentAddScore.addScoreId" class="form-control" placeholder="请输入加分id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="studentAddScore_studenObj_studentNumber_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="studentAddScore_studenObj_studentNumber_edit" name="studentAddScore.studenObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="studentAddScore_addScoreObj_itemId_edit" class="col-md-3 text-right">加分项目:</label>
		  	 <div class="col-md-9">
			    <select id="studentAddScore_addScoreObj_itemId_edit" name="studentAddScore.addScoreObj.itemId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="studentAddScore_proof_edit" class="col-md-3 text-right">证明材料:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="studentAddScore_proofImg" border="0px"/><br/>
			    <input type="hidden" id="studentAddScore_proof" name="studentAddScore.proof"/>
			    <input id="proofFile" name="proofFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="studentAddScore_shengQingShiJian_edit" class="col-md-3 text-right">申请时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="studentAddScore_shengQingShiJian_edit" name="studentAddScore.shengQingShiJian" class="form-control" placeholder="请输入申请时间">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="studentAddScore_shenHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="studentAddScore_shenHeState_edit" name="studentAddScore.shenHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="studentAddScore_shenHeTime_edit" class="col-md-3 text-right">审核时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="studentAddScore_shenHeTime_edit" name="studentAddScore.shenHeTime" class="form-control" placeholder="请输入审核时间">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxStudentAddScoreModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#studentAddScoreEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改学生加分界面并初始化数据*/
function studentAddScoreEdit(addScoreId) {
	$.ajax({
		url :  basePath + "StudentAddScore/" + addScoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (studentAddScore, response, status) {
			if (studentAddScore) {
				$("#studentAddScore_addScoreId_edit").val(studentAddScore.addScoreId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#studentAddScore_studenObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#studentAddScore_studenObj_studentNumber_edit").html(html);
		        		$("#studentAddScore_studenObj_studentNumber_edit").val(studentAddScore.studenObjPri);
					}
				});
				$.ajax({
					url: basePath + "AddScoreItem/listAll",
					type: "get",
					success: function(addScoreItems,response,status) { 
						$("#studentAddScore_addScoreObj_itemId_edit").empty();
						var html="";
		        		$(addScoreItems).each(function(i,addScoreItem){
		        			html += "<option value='" + addScoreItem.itemId + "'>" + addScoreItem.itemName + "</option>";
		        		});
		        		$("#studentAddScore_addScoreObj_itemId_edit").html(html);
		        		$("#studentAddScore_addScoreObj_itemId_edit").val(studentAddScore.addScoreObjPri);
					}
				});
				$("#studentAddScore_proof").val(studentAddScore.proof);
				$("#studentAddScore_proofImg").attr("src", basePath +　studentAddScore.proof);
				$("#studentAddScore_shengQingShiJian_edit").val(studentAddScore.shengQingShiJian);
				$("#studentAddScore_shenHeState_edit").val(studentAddScore.shenHeState);
				$("#studentAddScore_shenHeTime_edit").val(studentAddScore.shenHeTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交学生加分信息表单给服务器端修改*/
function ajaxStudentAddScoreModify() {
	$.ajax({
		url :  basePath + "StudentAddScore/" + $("#studentAddScore_addScoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#studentAddScoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#studentAddScoreQueryForm").submit();
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
    studentAddScoreEdit("<%=request.getParameter("addScoreId")%>");
 })
 </script> 
</body>
</html>

