<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.StudentAddScore" %>
<%@ page import="com.chengxusheji.po.AddScoreItem" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<StudentAddScore> studentAddScoreList = (List<StudentAddScore>)request.getAttribute("studentAddScoreList");
    //获取所有的addScoreObj信息
    List<AddScoreItem> addScoreItemList = (List<AddScoreItem>)request.getAttribute("addScoreItemList");
    //获取所有的studenObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Student studenObj = (Student)request.getAttribute("studenObj");
    AddScoreItem addScoreObj = (AddScoreItem)request.getAttribute("addScoreObj");
    String shenHeState = (String)request.getAttribute("shenHeState"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生加分查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>StudentAddScore/frontlist">学生加分信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>StudentAddScore/studentAddScore_frontAdd.jsp" style="display:none;">添加学生加分</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<studentAddScoreList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		StudentAddScore studentAddScore = studentAddScoreList.get(i); //获取到学生加分对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>StudentAddScore/<%=studentAddScore.getAddScoreId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=studentAddScore.getProof()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		加分id:<%=studentAddScore.getAddScoreId() %>
			     	</div>
			     	<div class="field">
	            		学生:<%=studentAddScore.getStudenObj().getStudentName() %>
			     	</div>
			     	<div class="field">
	            		加分项目:<%=studentAddScore.getAddScoreObj().getItemName() %>
			     	</div>
			     	<div class="field">
	            		申请时间:<%=studentAddScore.getShengQingShiJian() %>
			     	</div>
			     	<div class="field">
	            		审核状态:<%=studentAddScore.getShenHeState() %>
			     	</div>
			     	<div class="field">
	            		审核时间:<%=studentAddScore.getShenHeTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>StudentAddScore/<%=studentAddScore.getAddScoreId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="studentAddScoreEdit('<%=studentAddScore.getAddScoreId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="studentAddScoreDelete('<%=studentAddScore.getAddScoreId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

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

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>学生加分查询</h1>
		</div>
		<form name="studentAddScoreQueryForm" id="studentAddScoreQueryForm" action="<%=basePath %>StudentAddScore/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="studenObj_studentNumber">学生：</label>
                <select id="studenObj_studentNumber" name="studenObj.studentNumber" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studenObj!=null && studenObj.getStudentNumber()!=null && studenObj.getStudentNumber().equals(studentTemp.getStudentNumber()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getStudentNumber() %>" <%=selected %>><%=studentTemp.getStudentName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="addScoreObj_itemId">加分项目：</label>
                <select id="addScoreObj_itemId" name="addScoreObj.itemId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(AddScoreItem addScoreItemTemp:addScoreItemList) {
	 					String selected = "";
 					if(addScoreObj!=null && addScoreObj.getItemId()!=null && addScoreObj.getItemId().intValue()==addScoreItemTemp.getItemId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=addScoreItemTemp.getItemId() %>" <%=selected %>><%=addScoreItemTemp.getItemName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="shenHeState">审核状态:</label>
				<input type="text" id="shenHeState" name="shenHeState" value="<%=shenHeState %>" class="form-control" placeholder="请输入审核状态">
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="studentAddScoreEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;学生加分信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#studentAddScoreEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxStudentAddScoreModify();">提交</button>
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
    document.studentAddScoreQueryForm.currentPage.value = currentPage;
    document.studentAddScoreQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.studentAddScoreQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.studentAddScoreQueryForm.currentPage.value = pageValue;
    documentstudentAddScoreQueryForm.submit();
}

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
				$('#studentAddScoreEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除学生加分信息*/
function studentAddScoreDelete(addScoreId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "StudentAddScore/deletes",
			data : {
				addScoreIds : addScoreId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#studentAddScoreQueryForm").submit();
					//location.href= basePath + "StudentAddScore/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

