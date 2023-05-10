$(function () {
	$("#courseScore_studentObj_studentNumber").combobox({
	    url:'Student/listAll',
	    valueField: "studentNumber",
	    textField: "studentName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#courseScore_studentObj_studentNumber").combobox("getData"); 
            if (data.length > 0) {
                $("#courseScore_studentObj_studentNumber").combobox("select", data[0].studentNumber);
            }
        }
	});
	$("#courseScore_courseObj_courseNo").combobox({
	    url:'Course/listAll',
	    valueField: "courseNo",
	    textField: "courseName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#courseScore_courseObj_courseNo").combobox("getData"); 
            if (data.length > 0) {
                $("#courseScore_courseObj_courseNo").combobox("select", data[0].courseNo);
            }
        }
	});
	$("#courseScore_score").validatebox({
		required : true,
		validType : "number",
		missingMessage : '请输入成绩',
		invalidMessage : '成绩输入不对',
	});

	//单击添加按钮
	$("#courseScoreAddButton").click(function () {
		//验证表单 
		if(!$("#courseScoreAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#courseScoreAddForm").form({
			    url:"CourseScore/add",
			    onSubmit: function(){
					if($("#courseScoreAddForm").form("validate"))  { 
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
                        $("#courseScoreAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#courseScoreAddForm").submit();
		}
	});

	//单击清空按钮
	$("#courseScoreClearButton").click(function () { 
		$("#courseScoreAddForm").form("clear"); 
	});
});
