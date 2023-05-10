var addScoreItem_manage_tool = null; 
$(function () { 
	initAddScoreItemManageTool(); //建立AddScoreItem管理对象
	addScoreItem_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#addScoreItem_manage").datagrid({
		url : 'AddScoreItem/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "itemId",
		sortOrder : "desc",
		toolbar : "#addScoreItem_manage_tool",
		columns : [[
			{
				field : "itemId",
				title : "加分项目id",
				width : 70,
			},
			{
				field : "itemName",
				title : "加分项目名称",
				width : 140,
			},
			{
				field : "itemScore",
				title : "加分项目分数",
				width : 70,
			},
		]],
	});

	$("#addScoreItemEditDiv").dialog({
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
				if ($("#addScoreItemEditForm").form("validate")) {
					//验证表单 
					if(!$("#addScoreItemEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#addScoreItemEditForm").form({
						    url:"AddScoreItem/" + $("#addScoreItem_itemId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#addScoreItemEditForm").form("validate"))  {
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
			                        $("#addScoreItemEditDiv").dialog("close");
			                        addScoreItem_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#addScoreItemEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#addScoreItemEditDiv").dialog("close");
				$("#addScoreItemEditForm").form("reset"); 
			},
		}],
	});
});

function initAddScoreItemManageTool() {
	addScoreItem_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#addScoreItem_manage").datagrid("reload");
		},
		redo : function () {
			$("#addScoreItem_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#addScoreItem_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#addScoreItemQueryForm").form({
			    url:"AddScoreItem/OutToExcel",
			});
			//提交表单
			$("#addScoreItemQueryForm").submit();
		},
		remove : function () {
			var rows = $("#addScoreItem_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var itemIds = [];
						for (var i = 0; i < rows.length; i ++) {
							itemIds.push(rows[i].itemId);
						}
						$.ajax({
							type : "POST",
							url : "AddScoreItem/deletes",
							data : {
								itemIds : itemIds.join(","),
							},
							beforeSend : function () {
								$("#addScoreItem_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#addScoreItem_manage").datagrid("loaded");
									$("#addScoreItem_manage").datagrid("load");
									$("#addScoreItem_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#addScoreItem_manage").datagrid("loaded");
									$("#addScoreItem_manage").datagrid("load");
									$("#addScoreItem_manage").datagrid("unselectAll");
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
			var rows = $("#addScoreItem_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "AddScoreItem/" + rows[0].itemId +  "/update",
					type : "get",
					data : {
						//itemId : rows[0].itemId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (addScoreItem, response, status) {
						$.messager.progress("close");
						if (addScoreItem) { 
							$("#addScoreItemEditDiv").dialog("open");
							$("#addScoreItem_itemId_edit").val(addScoreItem.itemId);
							$("#addScoreItem_itemId_edit").validatebox({
								required : true,
								missingMessage : "请输入加分项目id",
								editable: false
							});
							$("#addScoreItem_itemName_edit").val(addScoreItem.itemName);
							$("#addScoreItem_itemName_edit").validatebox({
								required : true,
								missingMessage : "请输入加分项目名称",
							});
							$("#addScoreItem_itemScore_edit").val(addScoreItem.itemScore);
							$("#addScoreItem_itemScore_edit").validatebox({
								required : true,
								validType : "number",
								missingMessage : "请输入加分项目分数",
								invalidMessage : "加分项目分数输入不对",
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
