<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.ClassInfo" %>
<%@ page import="com.chengxusheji.po.Colleage" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<ClassInfo> classInfoList = (List<ClassInfo>)request.getAttribute("classInfoList");
    //获取所有的colleageObj信息
    List<Colleage> colleageList = (List<Colleage>)request.getAttribute("colleageList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String startDate = (String)request.getAttribute("startDate"); //开办日期查询关键字
    String classNumber = (String)request.getAttribute("classNumber"); //班级编号查询关键字
    String className = (String)request.getAttribute("className"); //班级名称查询关键字
    Colleage colleageObj = (Colleage)request.getAttribute("colleageObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>班级信息查询</title>
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
			    	<li role="presentation" class="active"><a href="#classInfoListPanel" aria-controls="classInfoListPanel" role="tab" data-toggle="tab">班级信息列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>ClassInfo/classInfo_frontAdd.jsp" style="display:none;">添加班级信息</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="classInfoListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>班级编号</td><td>班级名称</td><td>所在学院</td><td>班主任</td><td>开办日期</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<classInfoList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		ClassInfo classInfo = classInfoList.get(i); //获取到班级信息对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=classInfo.getClassNumber() %></td>
 											<td><%=classInfo.getClassName() %></td>
 											<td><%=classInfo.getColleageObj().getColleageName() %></td>
 											<td><%=classInfo.getBanzhuren() %></td>
 											<td><%=classInfo.getStartDate() %></td>
 											<td>
 												<a href="<%=basePath  %>ClassInfo/<%=classInfo.getClassNumber() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="classInfoEdit('<%=classInfo.getClassNumber() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="classInfoDelete('<%=classInfo.getClassNumber() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>班级信息查询</h1>
		</div>
		<form name="classInfoQueryForm" id="classInfoQueryForm" action="<%=basePath %>ClassInfo/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="startDate">开办日期:</label>
				<input type="text" id="startDate" name="startDate" class="form-control"  placeholder="请选择开办日期" value="<%=startDate %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="classNumber">班级编号:</label>
				<input type="text" id="classNumber" name="classNumber" value="<%=classNumber %>" class="form-control" placeholder="请输入班级编号">
			</div>






			<div class="form-group">
				<label for="className">班级名称:</label>
				<input type="text" id="className" name="className" value="<%=className %>" class="form-control" placeholder="请输入班级名称">
			</div>






            <div class="form-group">
            	<label for="colleageObj_colleageNumber">所在学院：</label>
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
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="classInfoEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;班级信息信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
                <div class="input-group date classInfo_startDate_edit col-md-12" data-link-field="classInfo_startDate_edit"  data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="classInfo_startDate_edit" name="classInfo.startDate" size="16" type="text" value="" placeholder="请选择开办日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		</form> 
	    <style>#classInfoEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxClassInfoModify();">提交</button>
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
    document.classInfoQueryForm.currentPage.value = currentPage;
    document.classInfoQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.classInfoQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.classInfoQueryForm.currentPage.value = pageValue;
    documentclassInfoQueryForm.submit();
}

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
				$('#classInfoEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除班级信息信息*/
function classInfoDelete(classNumber) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "ClassInfo/deletes",
			data : {
				classNumbers : classNumber,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#classInfoQueryForm").submit();
					//location.href= basePath + "ClassInfo/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

