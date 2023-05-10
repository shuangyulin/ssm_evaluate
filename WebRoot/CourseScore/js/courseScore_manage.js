var courseScore_manage_tool = null; 
$(function () { 
	initCourseScoreManageTool(); //建立CourseScore管理对象
	courseScore_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#courseScore_manage").datagrid({
		url : 'CourseScore/list',
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
		toolbar : "#courseScore_manage_tool",
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
				field : "courseObj",
				title : "课程",
				width : 140,
			},
			{
				field : "score",
				title : "成绩",
				width : 70,
			},
		]],
	});

	$("#courseScoreEditDiv").dialog({
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
				if ($("#courseScoreEditForm").form("validate")) {
					//验证表单 
					if(!$("#courseScoreEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#courseScoreEditForm").form({
						    url:"CourseScore/" + $("#courseScore_scoreId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#courseScoreEditForm").form("validate"))  {
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
			                        $("#courseScoreEditDiv").dialog("close");
			                        courseScore_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#courseScoreEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#courseScoreEditDiv").dialog("close");
				$("#courseScoreEditForm").form("reset"); 
			},
		}],
	});
});

function initCourseScoreManageTool() {
	courseScore_manage_tool = {
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
				url : "Course/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#courseObj_courseNo_query").combobox({ 
					    valueField:"courseNo",
					    textField:"courseName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{courseNo:"",courseName:"不限制"});
					$("#courseObj_courseNo_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#courseScore_manage").datagrid("reload");
		},
		redo : function () {
			$("#courseScore_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#courseScore_manage").datagrid("options").queryParams;
			queryParams["studentObj.studentNumber"] = $("#studentObj_studentNumber_query").combobox("getValue");
			queryParams["courseObj.courseNo"] = $("#courseObj_courseNo_query").combobox("getValue");
			$("#courseScore_manage").datagrid("options").queryParams=queryParams; 
			$("#courseScore_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#courseScoreQueryForm").form({
			    url:"CourseScore/OutToExcel",
			});
			//提交表单
			$("#courseScoreQueryForm").submit();
		},
		remove : function () {
			var rows = $("#courseScore_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var scoreIds = [];
						for (var i = 0; i < rows.length; i ++) {
							scoreIds.push(rows[i].scoreId);
						}
						$.ajax({
							type : "POST",
							url : "CourseScore/deletes",
							data : {
								scoreIds : scoreIds.join(","),
							},
							beforeSend : function () {
								$("#courseScore_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#courseScore_manage").datagrid("loaded");
									$("#courseScore_manage").datagrid("load");
									$("#courseScore_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#courseScore_manage").datagrid("loaded");
									$("#courseScore_manage").datagrid("load");
									$("#courseScore_manage").datagrid("unselectAll");
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
			var rows = $("#courseScore_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "CourseScore/" + rows[0].scoreId +  "/update",
					type : "get",
					data : {
						//scoreId : rows[0].scoreId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (courseScore, response, status) {
						$.messager.progress("close");
						if (courseScore) { 
							$("#courseScoreEditDiv").dialog("open");
							$("#courseScore_scoreId_edit").val(courseScore.scoreId);
							$("#courseScore_scoreId_edit").validatebox({
								required : true,
								missingMessage : "请输入成绩id",
								editable: false
							});
							$("#courseScore_studentObj_studentNumber_edit").combobox({
								url:"Student/listAll",
							    valueField:"studentNumber",
							    textField:"studentName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#courseScore_studentObj_studentNumber_edit").combobox("select", courseScore.studentObjPri);
									//var data = $("#courseScore_studentObj_studentNumber_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#courseScore_studentObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						            //}
								}
							});
							$("#courseScore_courseObj_courseNo_edit").combobox({
								url:"Course/listAll",
							    valueField:"courseNo",
							    textField:"courseName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#courseScore_courseObj_courseNo_edit").combobox("select", courseScore.courseObjPri);
									//var data = $("#courseScore_courseObj_courseNo_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#courseScore_courseObj_courseNo_edit").combobox("select", data[0].courseNo);
						            //}
								}
							});
							$("#courseScore_score_edit").val(courseScore.score);
							$("#courseScore_score_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入成绩",
								invalidMessage : "成绩输入不对",
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
