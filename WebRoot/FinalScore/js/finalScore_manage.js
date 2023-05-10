var finalScore_manage_tool = null; 
$(function () { 
	initFinalScoreManageTool(); //建立FinalScore管理对象
	finalScore_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#finalScore_manage").datagrid({
		url : 'FinalScore/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "scoreId",
		sortOrder : "desc",
		toolbar : "#finalScore_manage_tool",
		columns : [[
			{
				field : "scoreId",
				title : "成绩id",
				width : 70,
			},
			{
				field : "studentObj",
				title : "学生",
				width : 140,
			},
			{
				field : "colleageObj",
				title : "学院",
				width : 140,
			},
			{
				field : "classObj",
				title : "班级",
				width : 140,
			},
			{
				field : "courseFinalScore",
				title : "科目成绩折算分",
				width : 70,
			},
			{
				field : "finalAddScore",
				title : "各项目加分数",
				width : 70,
			},
			{
				field : "finalScore",
				title : "总分",
				width : 70,
			},
		]],
	});

	$("#finalScoreEditDiv").dialog({
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
				if ($("#finalScoreEditForm").form("validate")) {
					//验证表单 
					if(!$("#finalScoreEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#finalScoreEditForm").form({
						    url:"FinalScore/" + $("#finalScore_scoreId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#finalScoreEditForm").form("validate"))  {
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
			                        $("#finalScoreEditDiv").dialog("close");
			                        finalScore_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#finalScoreEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#finalScoreEditDiv").dialog("close");
				$("#finalScoreEditForm").form("reset"); 
			},
		}],
	});
});

function initFinalScoreManageTool() {
	finalScore_manage_tool = {
		init: function() {
			$.ajax({
				url : "Student/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#studentObj_studentNumber_query").combobox({ 
					    valueField:"studentNumber",
					    textField:"studentName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{studentNumber:"",studentName:"不限制"});
					$("#studentObj_studentNumber_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "Colleage/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#colleageObj_colleageNumber_query").combobox({ 
					    valueField:"colleageNumber",
					    textField:"colleageName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{colleageNumber:"",colleageName:"不限制"});
					$("#colleageObj_colleageNumber_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "ClassInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#classObj_classNumber_query").combobox({ 
					    valueField:"classNumber",
					    textField:"className",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{classNumber:"",className:"不限制"});
					$("#classObj_classNumber_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#finalScore_manage").datagrid("reload");
		},
		redo : function () {
			$("#finalScore_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#finalScore_manage").datagrid("options").queryParams;
			queryParams["studentObj.studentNumber"] = $("#studentObj_studentNumber_query").combobox("getValue");
			queryParams["colleageObj.colleageNumber"] = $("#colleageObj_colleageNumber_query").combobox("getValue");
			queryParams["classObj.classNumber"] = $("#classObj_classNumber_query").combobox("getValue");
			$("#finalScore_manage").datagrid("options").queryParams=queryParams; 
			$("#finalScore_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#finalScoreQueryForm").form({
			    url:"FinalScore/OutToExcel",
			});
			//提交表单
			$("#finalScoreQueryForm").submit();
		},
		remove : function () {
			var rows = $("#finalScore_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var scoreIds = [];
						for (var i = 0; i < rows.length; i ++) {
							scoreIds.push(rows[i].scoreId);
						}
						$.ajax({
							type : "POST",
							url : "FinalScore/deletes",
							data : {
								scoreIds : scoreIds.join(","),
							},
							beforeSend : function () {
								$("#finalScore_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#finalScore_manage").datagrid("loaded");
									$("#finalScore_manage").datagrid("load");
									$("#finalScore_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#finalScore_manage").datagrid("loaded");
									$("#finalScore_manage").datagrid("load");
									$("#finalScore_manage").datagrid("unselectAll");
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
			var rows = $("#finalScore_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "FinalScore/" + rows[0].scoreId +  "/update",
					type : "get",
					data : {
						//scoreId : rows[0].scoreId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (finalScore, response, status) {
						$.messager.progress("close");
						if (finalScore) { 
							$("#finalScoreEditDiv").dialog("open");
							$("#finalScore_scoreId_edit").val(finalScore.scoreId);
							$("#finalScore_scoreId_edit").validatebox({
								required : true,
								missingMessage : "请输入成绩id",
								editable: false
							});
							$("#finalScore_studentObj_studentNumber_edit").combobox({
								url:"Student/listAll",
							    valueField:"studentNumber",
							    textField:"studentName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#finalScore_studentObj_studentNumber_edit").combobox("select", finalScore.studentObjPri);
									//var data = $("#finalScore_studentObj_studentNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#finalScore_studentObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						            //}
								}
							});
							$("#finalScore_colleageObj_colleageNumber_edit").combobox({
								url:"Colleage/listAll",
							    valueField:"colleageNumber",
							    textField:"colleageName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#finalScore_colleageObj_colleageNumber_edit").combobox("select", finalScore.colleageObjPri);
									//var data = $("#finalScore_colleageObj_colleageNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#finalScore_colleageObj_colleageNumber_edit").combobox("select", data[0].colleageNumber);
						            //}
								}
							});
							$("#finalScore_classObj_classNumber_edit").combobox({
								url:"ClassInfo/listAll",
							    valueField:"classNumber",
							    textField:"className",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#finalScore_classObj_classNumber_edit").combobox("select", finalScore.classObjPri);
									//var data = $("#finalScore_classObj_classNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#finalScore_classObj_classNumber_edit").combobox("select", data[0].classNumber);
						            //}
								}
							});
							$("#finalScore_courseFinalScore_edit").val(finalScore.courseFinalScore);
							$("#finalScore_courseFinalScore_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入科目成绩折算分",
								invalidMessage : "科目成绩折算分输入不对",
							});
							$("#finalScore_finalAddScore_edit").val(finalScore.finalAddScore);
							$("#finalScore_finalAddScore_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入各项目加分数",
								invalidMessage : "各项目加分数输入不对",
							});
							$("#finalScore_finalScore_edit").val(finalScore.finalScore);
							$("#finalScore_finalScore_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入总分",
								invalidMessage : "总分输入不对",
							});
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
