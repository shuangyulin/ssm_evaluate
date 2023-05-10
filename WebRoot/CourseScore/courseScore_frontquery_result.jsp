<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseScore" %>
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<CourseScore> courseScoreList = (List<CourseScore>)request.getAttribute("courseScoreList");
    //获取所有的courseObj信息
    List<Course> courseList = (List<Course>)request.getAttribute("courseList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Student studentObj = (Student)request.getAttribute("studentObj");
    Course courseObj = (Course)request.getAttribute("courseObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>课程成绩查询</title>
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
			    	<li role="presentation" class="active"><a href="#courseScoreListPanel" aria-controls="courseScoreListPanel" role="tab" data-toggle="tab">课程成绩列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>CourseScore/courseScore_frontAdd.jsp" style="display:none;">添加课程成绩</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="courseScoreListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>成绩id</td><td>学生</td><td>课程</td><td>成绩</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<courseScoreList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		CourseScore courseScore = courseScoreList.get(i); //获取到课程成绩对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=courseScore.getScoreId() %></td>
 											<td><%=courseScore.getStudentObj().getStudentName() %></td>
 											<td><%=courseScore.getCourseObj().getCourseName() %></td>
 											<td><%=courseScore.getScore() %></td>
 											<td>
 												<a href="<%=basePath  %>CourseScore/<%=courseScore.getScoreId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="courseScoreEdit('<%=courseScore.getScoreId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="courseScoreDelete('<%=courseScore.getScoreId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>课程成绩查询</h1>
		</div>
		<form name="courseScoreQueryForm" id="courseScoreQueryForm" action="<%=basePath %>CourseScore/frontlist" class="mar_t15" method="post">
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
            	<label for="courseObj_courseNo">课程：</label>
                <select id="courseObj_courseNo" name="courseObj.courseNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Course courseTemp:courseList) {
	 					String selected = "";
 					if(courseObj!=null && courseObj.getCourseNo()!=null && courseObj.getCourseNo().equals(courseTemp.getCourseNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=courseTemp.getCourseNo() %>" <%=selected %>><%=courseTemp.getCourseName() %></option>
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
<div id="courseScoreEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;课程成绩信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="courseScoreEditForm" id="courseScoreEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="courseScore_scoreId_edit" class="col-md-3 text-right">成绩id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="courseScore_scoreId_edit" name="courseScore.scoreId" class="form-control" placeholder="请输入成绩id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="courseScore_studentObj_studentNumber_edit" class="col-md-3 text-right">学生:</label>
		  	 <div class="col-md-9">
			    <select id="courseScore_studentObj_studentNumber_edit" name="courseScore.studentObj.studentNumber" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseScore_courseObj_courseNo_edit" class="col-md-3 text-right">课程:</label>
		  	 <div class="col-md-9">
			    <select id="courseScore_courseObj_courseNo_edit" name="courseScore.courseObj.courseNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseScore_score_edit" class="col-md-3 text-right">成绩:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseScore_score_edit" name="courseScore.score" class="form-control" placeholder="请输入成绩">
			 </div>
		  </div>
		</form> 
	    <style>#courseScoreEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCourseScoreModify();">提交</button>
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
    document.courseScoreQueryForm.currentPage.value = currentPage;
    document.courseScoreQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.courseScoreQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.courseScoreQueryForm.currentPage.value = pageValue;
    documentcourseScoreQueryForm.submit();
}

/*弹出修改课程成绩界面并初始化数据*/
function courseScoreEdit(scoreId) {
	$.ajax({
		url :  basePath + "CourseScore/" + scoreId + "/update",
		type : "get",
		dataType: "json",
		success : function (courseScore, response, status) {
			if (courseScore) {
				$("#courseScore_scoreId_edit").val(courseScore.scoreId);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#courseScore_studentObj_studentNumber_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.studentNumber + "'>" + student.studentName + "</option>";
		        		});
		        		$("#courseScore_studentObj_studentNumber_edit").html(html);
		        		$("#courseScore_studentObj_studentNumber_edit").val(courseScore.studentObjPri);
					}
				});
				$.ajax({
					url: basePath + "Course/listAll",
					type: "get",
					success: function(courses,response,status) { 
						$("#courseScore_courseObj_courseNo_edit").empty();
						var html="";
		        		$(courses).each(function(i,course){
		        			html += "<option value='" + course.courseNo + "'>" + course.courseName + "</option>";
		        		});
		        		$("#courseScore_courseObj_courseNo_edit").html(html);
		        		$("#courseScore_courseObj_courseNo_edit").val(courseScore.courseObjPri);
					}
				});
				$("#courseScore_score_edit").val(courseScore.score);
				$('#courseScoreEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除课程成绩信息*/
function courseScoreDelete(scoreId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "CourseScore/deletes",
			data : {
				scoreIds : scoreId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#courseScoreQueryForm").submit();
					//location.href= basePath + "CourseScore/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交课程成绩信息表单给服务器端修改*/
function ajaxCourseScoreModify() {
	$.ajax({
		url :  basePath + "CourseScore/" + $("#courseScore_scoreId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseScoreEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#courseScoreQueryForm").submit();
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

