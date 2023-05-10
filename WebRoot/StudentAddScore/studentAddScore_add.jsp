<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/studentAddScore.css" />
<div id="studentAddScoreAddDiv">
	<form id="studentAddScoreAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_studenObj_studentNumber" name="studentAddScore.studenObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">加分项目:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_addScoreObj_itemId" name="studentAddScore.addScoreObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">证明材料:</span>
			<span class="inputControl">
				<input id="proofFile" name="proofFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">申请时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_shengQingShiJian" name="studentAddScore.shengQingShiJian" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_shenHeState" name="studentAddScore.shenHeState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_shenHeTime" name="studentAddScore.shenHeTime" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="studentAddScoreAddButton" class="easyui-linkbutton">添加</a>
			<a id="studentAddScoreClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/StudentAddScore/js/studentAddScore_add.js"></script> 
