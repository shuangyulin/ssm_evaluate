<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseScore.css" /> 

<div id="courseScore_manage"></div>
<div id="courseScore_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="courseScore_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="courseScore_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="courseScore_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="courseScore_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="courseScore_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="courseScoreQueryForm" method="post">
			学生：<input class="textbox" type="text" id="studentObj_studentNumber_query" name="studentObj.studentNumber" style="width: auto"/>
			课程：<input class="textbox" type="text" id="courseObj_courseNo_query" name="courseObj.courseNo" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="courseScore_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="courseScoreEditDiv">
	<form id="courseScoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseScore_scoreId_edit" name="courseScore.scoreId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="courseScore_studentObj_studentNumber_edit" name="courseScore.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程:</span>
			<span class="inputControl">
				<input class="textbox"  id="courseScore_courseObj_courseNo_edit" name="courseScore.courseObj.courseNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseScore_score_edit" name="courseScore.score" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="CourseScore/js/courseScore_manage.js"></script> 
