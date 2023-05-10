<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseScore.css" />
<div id="courseScoreAddDiv">
	<form id="courseScoreAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseScore_studentObj_studentNumber" name="courseScore.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">课程:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseScore_courseObj_courseNo" name="courseScore.courseObj.courseNo" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">成绩:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseScore_score" name="courseScore.score" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="courseScoreAddButton" class="easyui-linkbutton">添加</a>
			<a id="courseScoreClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/CourseScore/js/courseScore_add.js"></script> 
