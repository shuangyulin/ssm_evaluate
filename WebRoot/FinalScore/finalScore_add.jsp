<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/finalScore.css" />
<div id="finalScoreAddDiv">
	<form id="finalScoreAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_studentObj_studentNumber" name="finalScore.studentObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_colleageObj_colleageNumber" name="finalScore.colleageObj.colleageNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">班级:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_classObj_classNumber" name="finalScore.classObj.classNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">科目成绩折算分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_courseFinalScore" name="finalScore.courseFinalScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">各项目加分数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_finalAddScore" name="finalScore.finalAddScore" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">总分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="finalScore_finalScore" name="finalScore.finalScore" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="finalScoreAddButton" class="easyui-linkbutton">添加</a>
			<a id="finalScoreClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/FinalScore/js/finalScore_add.js"></script> 
