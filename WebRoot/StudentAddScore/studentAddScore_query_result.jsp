<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/studentAddScore.css" /> 

<div id="studentAddScore_manage"></div>
<div id="studentAddScore_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="studentAddScore_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="studentAddScore_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="studentAddScore_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="studentAddScore_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="studentAddScore_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="studentAddScoreQueryForm" method="post">
			学生：<input class="textbox" type="text" id="studenObj_studentNumber_query" name="studenObj.studentNumber" style="width: auto"/>
			加分项目：<input class="textbox" type="text" id="addScoreObj_itemId_query" name="addScoreObj.itemId" style="width: auto"/>
			审核状态：<input type="text" class="textbox" id="shenHeState" name="shenHeState" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="studentAddScore_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="studentAddScoreEditDiv">
	<form id="studentAddScoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">加分id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_addScoreId_edit" name="studentAddScore.addScoreId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">学生:</span>
			<span class="inputControl">
				<input class="textbox"  id="studentAddScore_studenObj_studentNumber_edit" name="studentAddScore.studenObj.studentNumber" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">加分项目:</span>
			<span class="inputControl">
				<input class="textbox"  id="studentAddScore_addScoreObj_itemId_edit" name="studentAddScore.addScoreObj.itemId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">证明材料:</span>
			<span class="inputControl">
				<img id="studentAddScore_proofImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="studentAddScore_proof" name="studentAddScore.proof"/>
				<input id="proofFile" name="proofFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">申请时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_shengQingShiJian_edit" name="studentAddScore.shengQingShiJian" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_shenHeState_edit" name="studentAddScore.shenHeState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">审核时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_shenHeTime_edit" name="studentAddScore.shenHeTime" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="StudentAddScore/js/studentAddScore_manage.js"></script> 
