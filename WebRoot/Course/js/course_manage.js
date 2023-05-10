var course_manage_tool = null; 
$(function () { 
	initCourseManageTool(); //建立Course管理对象
	course_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#course_manage").datagrid({
		url : 'Course/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "courseNo",
		sortOrder : "desc",
		toolbar : "#course_manage_tool",
		columns : [[
			{
				field : "courseNo",
				title : "课程编号",
				width : 140,
			},
			{
				field : "courseName",
				title : "课程名称",
				width : 140,
			},
			{
				field : "courseType",
				title : "课程类型",
				width : 140,
			},
			{
				field : "courseScore",
				title : "课程学分",
				width : 70,
			},
			{
				field : "teacherName",
				title : "上课老师",
				width : 140,
			},
			{
				field : "courseHour",
				title : "课程总学时",
				width : 70,
			},
		]],
	});

	$("#courseEditDiv").dialog({
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
				if ($("#courseEditForm").form("validate")) {
					//验证表单 
					if(!$("#courseEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#courseEditForm").form({
						    url:"Course/" + $("#course_courseNo_edit").val() + "/update",
						    onSubmit: function(){
								if($("#courseEditForm").form("validate"))  {
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
			                        $("#courseEditDiv").dialog("close");
			                        course_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#courseEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#courseEditDiv").dialog("close");
				$("#courseEditForm").form("reset"); 
			},
		}],
	});
});

function initCourseManageTool() {
	course_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#course_manage").datagrid("reload");
		},
		redo : function () {
			$("#course_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#course_manage").datagrid("options").queryParams;
			queryParams["courseNo"] = $("#courseNo").val();
			queryParams["courseName"] = $("#courseName").val();
			queryParams["courseType"] = $("#courseType").val();
			$("#course_manage").datagrid("options").queryParams=queryParams; 
			$("#course_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#courseQueryForm").form({
			    url:"Course/OutToExcel",
			});
			//提交表单
			$("#courseQueryForm").submit();
		},
		remove : function () {
			var rows = $("#course_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var courseNos = [];
						for (var i = 0; i < rows.length; i ++) {
							courseNos.push(rows[i].courseNo);
						}
						$.ajax({
							type : "POST",
							url : "Course/deletes",
							data : {
								courseNos : courseNos.join(","),
							},
							beforeSend : function () {
								$("#course_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#course_manage").datagrid("loaded");
									$("#course_manage").datagrid("load");
									$("#course_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#course_manage").datagrid("loaded");
									$("#course_manage").datagrid("load");
									$("#course_manage").datagrid("unselectAll");
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
			var rows = $("#course_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Course/" + rows[0].courseNo +  "/update",
					type : "get",
					data : {
						//courseNo : rows[0].courseNo,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (course, response, status) {
						$.messager.progress("close");
						if (course) { 
							$("#courseEditDiv").dialog("open");
							$("#course_courseNo_edit").val(course.courseNo);
							$("#course_courseNo_edit").validatebox({
								required : true,
								missingMessage : "请输入课程编号",
								editable: false
							});
							$("#course_courseName_edit").val(course.courseName);
							$("#course_courseName_edit").validatebox({
								required : true,
								missingMessage : "请输入课程名称",
							});
							$("#course_courseType_edit").val(course.courseType);
							$("#course_courseType_edit").validatebox({
								required : true,
								missingMessage : "请输入课程类型",
							});
							$("#course_courseScore_edit").val(course.courseScore);
							$("#course_courseScore_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入课程学分",
								invalidMessage : "课程学分输入不对",
							});
							$("#course_teacherName_edit").val(course.teacherName);
							$("#course_teacherName_edit").validatebox({
								required : true,
								missingMessage : "请输入上课老师",
							});
							$("#course_courseHour_edit").val(course.courseHour);
							$("#course_courseHour_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入课程总学时",
								invalidMessage : "课程总学时输入不对",
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
