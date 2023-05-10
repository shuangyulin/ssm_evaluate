<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/finalScore.css" />
<div id="finalScore_editDiv">
	<form id="finalScoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">成绩id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_scoreId_edit" name="finalScore.scoreId" value="<%=request.getParameter("scoreId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="finalScoreModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/FinalScore/js/finalScore_modify.js"></script> 
