<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/addScoreItem.css" /> 

<div id="addScoreItem_manage"></div>
<div id="addScoreItem_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="addScoreItem_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="addScoreItem_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="addScoreItem_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="addScoreItem_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="addScoreItem_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="addScoreItemQueryForm" method="post">
		</form>	
	</div>
</div>

<div id="addScoreItemEditDiv">
	<form id="addScoreItemEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">加分项目id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="addScoreItem_itemId_edit" name="addScoreItem.itemId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="AddScoreItem/js/addScoreItem_manage.js"></script> 
