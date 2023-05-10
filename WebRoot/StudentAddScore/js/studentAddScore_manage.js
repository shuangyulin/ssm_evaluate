var studentAddScore_manage_tool = null; 
$(function () { 
	initStudentAddScoreManageTool(); //建立StudentAddScore管理对象
	studentAddScore_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#studentAddScore_manage").datagrid({
		url : 'StudentAddScore/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "addScoreId",
		sortOrder : "desc",
		toolbar : "#studentAddScore_manage_tool",
		columns : [[
			{
				field : "addScoreId",
				title : "加分id",
				width : 70,
			},
			{
				field : "studenObj",
				title : "学生",
				width : 140,
			},
			{
				field : "addScoreObj",
				title : "加分项目",
				width : 140,
			},
			{
				field : "proof",
				title : "证明材料",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "shengQingShiJian",
				title : "申请时间",
				width : 140,
			},
			{
				field : "shenHeState",
				title : "审核状态",
				width : 140,
			},
			{
				field : "shenHeTime",
				title : "审核时间",
				width : 140,
			},
		]],
	});

	$("#studentAddScoreEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#studentAddScoreEditForm").form("validate")) {
					//验证表单 
					if(!$("#studentAddScoreEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#studentAddScoreEditForm").form({
						    url:"StudentAddScore/" + $("#studentAddScore_addScoreId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#studentAddScoreEditForm").form("validate"))  {
				                	$.messager.progress({
										text : "正在提交数据中...",
									});
				                	return true;
				                } else { 
				                    return false; 
				                }
						    },
						    success:function(data){
						    	$.messager.progress("close");
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#studentAddScoreEditDiv").dialog("close");
			                        studentAddScore_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#studentAddScoreEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#studentAddScoreEditDiv").dialog("close");
				$("#studentAddScoreEditForm").form("reset"); 
			},
		}],
	});
});

function initStudentAddScoreManageTool() {
	studentAddScore_manage_tool = {
		init: function() {
			$.ajax({
				url : "Student/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#studenObj_studentNumber_query").combobox({ 
					    valueField:"studentNumber",
					    textField:"studentName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{studentNumber:"",studentName:"不限制"});
					$("#studenObj_studentNumber_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "AddScoreItem/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#addScoreObj_itemId_query").combobox({ 
					    valueField:"itemId",
					    textField:"itemName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{itemId:0,itemName:"不限制"});
					$("#addScoreObj_itemId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#studentAddScore_manage").datagrid("reload");
		},
		redo : function () {
			$("#studentAddScore_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#studentAddScore_manage").datagrid("options").queryParams;
			queryParams["studenObj.studentNumber"] = $("#studenObj_studentNumber_query").combobox("getValue");
			queryParams["addScoreObj.itemId"] = $("#addScoreObj_itemId_query").combobox("getValue");
			queryParams["shenHeState"] = $("#shenHeState").val();
			$("#studentAddScore_manage").datagrid("options").queryParams=queryParams; 
			$("#studentAddScore_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#studentAddScoreQueryForm").form({
			    url:"StudentAddScore/OutToExcel",
			});
			//提交表单
			$("#studentAddScoreQueryForm").submit();
		},
		remove : function () {
			var rows = $("#studentAddScore_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var addScoreIds = [];
						for (var i = 0; i < rows.length; i ++) {
							addScoreIds.push(rows[i].addScoreId);
						}
						$.ajax({
							type : "POST",
							url : "StudentAddScore/deletes",
							data : {
								addScoreIds : addScoreIds.join(","),
							},
							beforeSend : function () {
								$("#studentAddScore_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#studentAddScore_manage").datagrid("loaded");
									$("#studentAddScore_manage").datagrid("load");
									$("#studentAddScore_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#studentAddScore_manage").datagrid("loaded");
									$("#studentAddScore_manage").datagrid("load");
									$("#studentAddScore_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#studentAddScore_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "StudentAddScore/" + rows[0].addScoreId +  "/update",
					type : "get",
					data : {
						//addScoreId : rows[0].addScoreId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (studentAddScore, response, status) {
						$.messager.progress("close");
						if (studentAddScore) { 
							$("#studentAddScoreEditDiv").dialog("open");
							$("#studentAddScore_addScoreId_edit").val(studentAddScore.addScoreId);
							$("#studentAddScore_addScoreId_edit").validatebox({
								required : true,
								missingMessage : "请输入加分id",
								editable: false
							});
							$("#studentAddScore_studenObj_studentNumber_edit").combobox({
								url:"Student/listAll",
							    valueField:"studentNumber",
							    textField:"studentName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#studentAddScore_studenObj_studentNumber_edit").combobox("select", studentAddScore.studenObjPri);
									//var data = $("#studentAddScore_studenObj_studentNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#studentAddScore_studenObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						            //}
								}
							});
							$("#studentAddScore_addScoreObj_itemId_edit").combobox({
								url:"AddScoreItem/listAll",
							    valueField:"itemId",
							    textField:"itemName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#studentAddScore_addScoreObj_itemId_edit").combobox("select", studentAddScore.addScoreObjPri);
									//var data = $("#studentAddScore_addScoreObj_itemId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#studentAddScore_addScoreObj_itemId_edit").combobox("select", data[0].itemId);
						            //}
								}
							});
							$("#studentAddScore_proof").val(studentAddScore.proof);
							$("#studentAddScore_proofImg").attr("src", studentAddScore.proof);
							$("#studentAddScore_shengQingShiJian_edit").val(studentAddScore.shengQingShiJian);
							$("#studentAddScore_shenHeState_edit").val(studentAddScore.shenHeState);
							$("#studentAddScore_shenHeState_edit").validatebox({
								required : true,
								missingMessage : "请输入审核状态",
							});
							$("#studentAddScore_shenHeTime_edit").val(studentAddScore.shenHeTime);
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
