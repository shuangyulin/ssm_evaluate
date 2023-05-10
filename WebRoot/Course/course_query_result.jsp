<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/course.css" /> 

<div id="course_manage"></div>
<div id="course_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="course_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="course_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="course_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="course_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="course_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="courseQueryForm" method="post">
			课程编号：<input type="text" class="textbox" id="courseNo" name="courseNo" style="width:110px" />
			课程名称：<input type="text" class="textbox" id="courseName" name="courseName" style="width:110px" />
			课程类型：<input type="text" class="textbox" id="courseType" name="courseType" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="course_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="courseEditDiv">
	<form id="courseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseNo_edit" name="course.courseNo" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">课程名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseName_edit" name="course.courseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseType_edit" name="course.courseType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseScore_edit" name="course.courseScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">上课老师:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_teacherName_edit" name="course.teacherName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程总学时:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseHour_edit" name="course.courseHour" style="width:80px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="Course/js/course_manage.js"></script> 
