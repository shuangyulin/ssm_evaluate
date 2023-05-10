<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/course.css" />
<div id="courseAddDiv">
	<form id="courseAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">课程编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseNo" name="course.courseNo" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseName" name="course.courseName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程类型:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseType" name="course.courseType" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseScore" name="course.courseScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">上课老师:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_teacherName" name="course.teacherName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">课程总学时:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="course_courseHour" name="course.courseHour" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="courseAddButton" class="easyui-linkbutton">添加</a>
			<a id="courseClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Course/js/course_add.js"></script> 
