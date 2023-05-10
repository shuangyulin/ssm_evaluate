<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addScoreItem.css" />
<div id="addScoreItemAddDiv">
	<form id="addScoreItemAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">加分项目名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="addScoreItem_itemName" name="addScoreItem.itemName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">加分项目分数:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="addScoreItem_itemScore" name="addScoreItem.itemScore" style="width:80px" />

			</span>

		</div>
		<div class="operation">
			<a id="addScoreItemAddButton" class="easyui-linkbutton">添加</a>
			<a id="addScoreItemClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/AddScoreItem/js/addScoreItem_add.js"></script> 
