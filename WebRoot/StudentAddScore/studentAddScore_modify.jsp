<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/studentAddScore.css" />
<div id="studentAddScore_editDiv">
	<form id="studentAddScoreEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">加分id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="studentAddScore_addScoreId_edit" name="studentAddScore.addScoreId" value="<%=request.getParameter("addScoreId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="studentAddScoreModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/StudentAddScore/js/studentAddScore_modify.js"></script> 
