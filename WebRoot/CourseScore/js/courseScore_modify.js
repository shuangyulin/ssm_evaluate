$(function () {
	$.ajax({
		url : "CourseScore/" + $("#courseScore_scoreId_edit").val() + "/update",
		type : "get",
		data : {
			//scoreId : $("#courseScore_scoreId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (courseScore, response, status) {
			$.messager.progress("close");
			if (courseScore) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#courseScoreModifyButton").click(function(){ 
		if ($("#courseScoreEditForm").form("validate")) {
			$("#courseScoreEditForm").form({
			    url:"CourseScore/" +  $("#courseScore_scoreId_edit").val() + "/update",
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
			$("#courseScoreEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
