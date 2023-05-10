<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/colleage.css" />
<div id="colleage_editDiv">
	<form id="colleageEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">学院编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="colleage_colleageNumber_edit" name="colleage.colleageNumber" value="<%=request.getParameter("colleageNumber") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">学院名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="colleage_colleageName_edit" name="colleage.colleageName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="colleageModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Colleage/js/colleage_modify.js"></script> 
