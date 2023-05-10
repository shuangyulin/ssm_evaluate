<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/finalScore.css" /> 

<div id="finalScore_manage"></div>
<div id="finalScore_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="finalScore_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="finalScore_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="finalScore_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="finalScore_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="finalScore_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="finalScoreQueryForm" method="post">
			学生：<input class="textbox" type="text" id="studentObj_studentNumber_query" name="studentObj.studentNumber" style="width: auto"/>
			学院：<input class="textbox" type="text" id="colleageObj_colleageNumber_query" name="colleageObj.colleageNumber" style="width: auto"/>
			班级：<input class="textbox" type="text" id="classObj_classNumber_query" name="classObj.classNumber" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="finalScore_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="finalScoreEditDiv">
	<form id="finalScoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_scoreId_edit" name="finalScore.scoreId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="finalScore_studentObj_studentNumber_edit" name="finalScore.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学院:</span>
			<span class="inputControl">
				<input class="textbox"  id="finalScore_colleageObj_colleageNumber_edit" name="finalScore.colleageObj.colleageNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">班级:</span>
			<span class="inputControl">
				<input class="textbox"  id="finalScore_classObj_classNumber_edit" name="finalScore.classObj.classNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">科目成绩折算分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_courseFinalScore_edit" name="finalScore.courseFinalScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">各项目加分数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_finalAddScore_edit" name="finalScore.finalAddScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">总分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_finalScore_edit" name="finalScore.finalScore" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="FinalScore/js/finalScore_manage.js"></script> 
