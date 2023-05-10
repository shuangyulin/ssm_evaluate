<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/courseScore.css" />
<div id="courseScore_editDiv">
	<form id="courseScoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="courseScore_scoreId_edit" name="courseScore.scoreId" value="<%=request.getParameter("scoreId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="courseScoreModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/CourseScore/js/courseScore_modify.js"></script> 
