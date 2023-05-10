<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/classInfo.css" />
<div id="classInfoAddDiv">
	<form id="classInfoAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">班级编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_classNumber" name="classInfo.classNumber" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">班级名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_className" name="classInfo.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_colleageObj_colleageNumber" name="classInfo.colleageObj.colleageNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">班主任:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_banzhuren" name="classInfo.banzhuren" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">开办日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_startDate" name="classInfo.startDate" />

			</span>

		</div>
		<div class="operation">
			<a id="classInfoAddButton" class="easyui-linkbutton">添加</a>
			<a id="classInfoClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/ClassInfo/js/classInfo_add.js"></script> 
