$(function () {
	$.ajax({
		url : "AddScoreItem/" + $("#addScoreItem_itemId_edit").val() + "/update",
		type : "get",
		data : {
			//itemId : $("#addScoreItem_itemId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (addScoreItem, response, status) {
			$.messager.progress("close");
			if (addScoreItem) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#addScoreItemModifyButton").click(function(){ 
		if ($("#addScoreItemEditForm").form("validate")) {
			$("#addScoreItemEditForm").form({
			    url:"AddScoreItem/" +  $("#addScoreItem_itemId_edit").val() + "/update",
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
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#addScoreItemEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
