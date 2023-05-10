<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/classInfo.css" /> 

<div id="classInfo_manage"></div>
<div id="classInfo_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="classInfo_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="classInfo_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="classInfo_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="classInfo_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="classInfo_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="classInfoQueryForm" method="post">
			开办日期：<input type="text" id="startDate" name="startDate" class="easyui-datebox" editable="false" style="width:100px">
			班级编号：<input type="text" class="textbox" id="classNumber" name="classNumber" style="width:110px" />
			班级名称：<input type="text" class="textbox" id="className" name="className" style="width:110px" />
			所在学院：<input class="textbox" type="text" id="colleageObj_colleageNumber_query" name="colleageObj.colleageNumber" style="width: auto"/>
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="classInfo_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="classInfoEditDiv">
	<form id="classInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">班级编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_classNumber_edit" name="classInfo.classNumber" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">班级名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_className_edit" name="classInfo.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox"  id="classInfo_colleageObj_colleageNumber_edit" name="classInfo.colleageObj.colleageNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">班主任:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_banzhuren_edit" name="classInfo.banzhuren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">开办日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_startDate_edit" name="classInfo.startDate" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="ClassInfo/js/classInfo_manage.js"></script> 
