$(function () {
	$("#finalScore_studentObj_studentNumber").combobox({
	    url:'Student/listAll',
	    valueField: "studentNumber",
	    textField: "studentName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#finalScore_studentObj_studentNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#finalScore_studentObj_studentNumber").combobox("select", data[0].studentNumber);
            }
        }
	});
	$("#finalScore_colleageObj_colleageNumber").combobox({
	    url:'Colleage/listAll',
	    valueField: "colleageNumber",
	    textField: "colleageName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#finalScore_colleageObj_colleageNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#finalScore_colleageObj_colleageNumber").combobox("select", data[0].colleageNumber);
            }
        }
	});
	$("#finalScore_classObj_classNumber").combobox({
	    url:'ClassInfo/listAll',
	    valueField: "classNumber",
	    textField: "className",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#finalScore_classObj_classNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#finalScore_classObj_classNumber").combobox("select", data[0].classNumber);
            }
        }
	});
	$("#finalScore_courseFinalScore").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入科目成绩折算分',
		invalidMessage : '科目成绩折算分输入不对',
	});

	$("#finalScore_finalAddScore").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入各项目加分数',
		invalidMessage : '各项目加分数输入不对',
	});

	$("#finalScore_finalScore").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入总分',
		invalidMessage : '总分输入不对',
	});

	//单击添加按钮
	$("#finalScoreAddButton").click(function () {
		//验证表单 
		if(!$("#finalScoreAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#finalScoreAddForm").form({
			    url:"FinalScore/add",
			    onSubmit: function(){
					if($("#finalScoreAddForm").form("validate"))  { 
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
                        $("#finalScoreAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#finalScoreAddForm").submit();
		}
	});

	//单击清空按钮
	$("#finalScoreClearButton").click(function () { 
		$("#finalScoreAddForm").form("clear"); 
	});
});
