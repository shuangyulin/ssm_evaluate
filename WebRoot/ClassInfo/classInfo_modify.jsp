<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/classInfo.css" />
<div id="classInfo_editDiv">
	<form id="classInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">班级编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_classNumber_edit" name="classInfo.classNumber" value="<%=request.getParameter("classNumber") %>" style="width:200px" />
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
		<div class="operation">
			<a id="classInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ClassInfo/js/classInfo_modify.js"></script> 
