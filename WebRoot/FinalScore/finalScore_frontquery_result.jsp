<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.FinalScore" %>
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ page import="com.chengxusheji.po.Colleage" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<FinalScore> finalScoreList = (List<FinalScore>)request.getAttribute("finalScoreList");
    //获取所有的classObj信息
    List<ClassInfo> classInfoList = (List<ClassInfo>)request.getAttribute("classInfoList");
    //获取所有的colleageObj信息
    List<Colleage> colleageList = (List<Colleage>)request.getAttribute("colleageList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Student studentObj = (Student)request.getAttribute("studentObj");
    Colleage colleageObj = (Colleage)request.getAttribute("colleageObj");
    ClassInfo classObj = (ClassInfo)request.getAttribute("classObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>综合成绩查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#finalScoreListPanel" aria-controls="finalScoreListPanel" role="tab" data-toggle="tab">综合成绩列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>FinalScore/finalScore_frontAdd.jsp" style="display:none;">添加综合成绩</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="finalScoreListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>成绩id</td><td>学生</td><td>学院</td><td>班级</td><td>科目成绩折算分</td><td>各项目加分数</td><td>总分</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<finalScoreList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		FinalScore finalScore = finalScoreList.get(i); //获取到综合成绩对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=finalScore.getScoreId() %></td>
 											<td><%=finalScore.getStudentObj().getStudentName() %></td>
 											<td><%=finalScore.getColleageObj().getColleageName() %></td>
 											<td><%=finalScore.getClassObj().getClassName() %></td>
 											<td><%=finalScore.getCourseFinalScore() %></td>
 											<td><%=finalScore.getFinalAddScore() %></td>
 											<td><%=finalScore.getFinalScore() %></td>
 											<td>
 												<a href="<%=basePath  %>FinalScore/<%=finalScore.getScoreId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="finalScoreEdit('<%=finalScore.getScoreId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="finalScoreDelete('<%=finalScore.getScoreId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>综合成绩查询</h1>
		</div>
		<form name="finalScoreQueryForm" id="finalScoreQueryForm" action="<%=basePath %>FinalScore/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="studentObj_studentNumber">学生：</label>
                <select id="studentObj_studentNumber" name="studentObj.studentNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studentObj!=null && studentObj.getStudentNumber()!=null && studentObj.getStudentNumber().equals(studentTemp.getStudentNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getStudentNumber() %>" <%=selected %>><%=studentTemp.getStudentName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="colleageObj_colleageNumber">学院：</label>
                <select id="colleageObj_colleageNumber" name="colleageObj.colleageNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Colleage colleageTemp:colleageList) {
	 					String selected = "";
 					if(colleageObj!=null && colleageObj.getColleageNumber()!=null && colleageObj.getColleageNumber().equals(colleageTemp.getColleageNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=colleageTemp.getColleageNumber() %>" <%=selected %>><%=colleageTemp.getColleageName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="classObj_classNumber">班级：</label>
                <select id="classObj_classNumber" name="classObj.classNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(ClassInfo classInfoTemp:classInfoList) {
	 					String selected = "";
 					if(classObj!=null && classObj.getClassNumber()!=null && classObj.getClassNumber().equals(classInfoTemp.getClassNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=classInfoTemp.getClassNumber() %>" <%=selected %>><%=classInfoTemp.getClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="finalScoreEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;综合成绩信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#finalScoreEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxFinalScoreModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.finalScoreQueryForm.currentPage.value = currentPage;
    document.finalScoreQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.finalScoreQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.finalScoreQueryForm.currentPage.value = pageValue;
    documentfinalScoreQueryForm.submit();
}

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
				$('#finalScoreEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除综合成绩信息*/
function finalScoreDelete(scoreId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "FinalScore/deletes",
			data : {
				scoreIds : scoreId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#finalScoreQueryForm").submit();
					//location.href= basePath + "FinalScore/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

