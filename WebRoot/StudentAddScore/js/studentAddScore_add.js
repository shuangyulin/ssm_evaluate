$(function () {
	$("#studentAddScore_studenObj_studentNumber").combobox({
	    url:'Student/listAll',
	    valueField: "studentNumber",
	    textField: "studentName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#studentAddScore_studenObj_studentNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#studentAddScore_studenObj_studentNumber").combobox("select", data[0].studentNumber);
            }
        }
	});
	$("#studentAddScore_addScoreObj_itemId").combobox({
	    url:'AddScoreItem/listAll',
	    valueField: "itemId",
	    textField: "itemName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#studentAddScore_addScoreObj_itemId").combobox("getData"); 
            if (data.length > 0) {
                $("#studentAddScore_addScoreObj_itemId").combobox("select", data[0].itemId);
            }
        }
	});
	$("#studentAddScore_shenHeState").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	//单击添加按钮
	$("#studentAddScoreAddButton").click(function () {
		//验证表单 
		if(!$("#studentAddScoreAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#studentAddScoreAddForm").form({
			    url:"StudentAddScore/add",
			    onSubmit: function(){
					if($("#studentAddScoreAddForm").form("validate"))  { 
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
                        $("#studentAddScoreAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#studentAddScoreAddForm").submit();
		}
	});

	//单击清空按钮
	$("#studentAddScoreClearButton").click(function () { 
		$("#studentAddScoreAddForm").form("clear"); 
	});
});
