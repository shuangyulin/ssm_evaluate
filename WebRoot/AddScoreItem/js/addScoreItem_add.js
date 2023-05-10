$(function () {
	$("#addScoreItem_itemName").validatebox({
		required : true, 
		missingMessage : '请输入加分项目名称',
	});

	$("#addScoreItem_itemScore").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入加分项目分数',
		invalidMessage : '加分项目分数输入不对',
	});

	//单击添加按钮
	$("#addScoreItemAddButton").click(function () {
		//验证表单 
		if(!$("#addScoreItemAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#addScoreItemAddForm").form({
			    url:"AddScoreItem/add",
			    onSubmit: function(){
					if($("#addScoreItemAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#addScoreItemAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#addScoreItemAddForm").submit();
		}
	});

	//单击清空按钮
	$("#addScoreItemClearButton").click(function () { 
		$("#addScoreItemAddForm").form("clear"); 
	});
});
