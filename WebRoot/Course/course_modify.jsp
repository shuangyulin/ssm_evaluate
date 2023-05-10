<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/course.css" />
<div id="course_editDiv">
	<form id="courseEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseNo_edit" name="course.courseNo" value="<%=request.getParameter("courseNo") %>" style="width:200px" />
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
		<div class="operation">
			<a id="courseModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Course/js/course_modify.js"></script> 
