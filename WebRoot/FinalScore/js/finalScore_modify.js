$(function () {
	$.ajax({
		url : "FinalScore/" + $("#finalScore_scoreId_edit").val() + "/update",
		type : "get",
		data : {
			//scoreId : $("#finalScore_scoreId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (finalScore, response, status) {
			$.messager.progress("close");
			if (finalScore) { 
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
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#finalScoreModifyButton").click(function(){ 
		if ($("#finalScoreEditForm").form("validate")) {
			$("#finalScoreEditForm").form({
			    url:"FinalScore/" +  $("#finalScore_scoreId_edit").val() + "/update",
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
			$("#finalScoreEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
