<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addScoreItem.css" />
<div id="addScoreItem_editDiv">
	<form id="addScoreItemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">加分项目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="addScoreItem_itemId_edit" name="addScoreItem.itemId" value="<%=request.getParameter("itemId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">加分项目名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="addScoreItem_itemName_edit" name="addScoreItem.itemName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">加分项目分数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="addScoreItem_itemScore_edit" name="addScoreItem.itemScore" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="addScoreItemModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/AddScoreItem/js/addScoreItem_modify.js"></script> 
