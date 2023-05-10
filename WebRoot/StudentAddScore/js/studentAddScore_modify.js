$(function () {
	$.ajax({
		url : "StudentAddScore/" + $("#studentAddScore_addScoreId_edit").val() + "/update",
		type : "get",
		data : {
			//addScoreId : $("#studentAddScore_addScoreId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (studentAddScore, response, status) {
			$.messager.progress("close");
			if (studentAddScore) { 
				$("#studentAddScore_addScoreId_edit").val(studentAddScore.addScoreId);
				$("#studentAddScore_addScoreId_edit").validatebox({
					required : true,
					missingMessage : "请输入加分id",
					editable: false
				});
				$("#studentAddScore_studenObj_studentNumber_edit").combobox({
					url:"Student/listAll",
					valueField:"studentNumber",
					textField:"studentName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#studentAddScore_studenObj_studentNumber_edit").combobox("select", studentAddScore.studenObjPri);
						//var data = $("#studentAddScore_studenObj_studentNumber_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#studentAddScore_studenObj_studentNumber_edit").combobox("select", data[0].studentNumber);
						//}
					}
				});
				$("#studentAddScore_addScoreObj_itemId_edit").combobox({
					url:"AddScoreItem/listAll",
					valueField:"itemId",
					textField:"itemName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#studentAddScore_addScoreObj_itemId_edit").combobox("select", studentAddScore.addScoreObjPri);
						//var data = $("#studentAddScore_addScoreObj_itemId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#studentAddScore_addScoreObj_itemId_edit").combobox("select", data[0].itemId);
						//}
					}
				});
				$("#studentAddScore_proof").val(studentAddScore.proof);
				$("#studentAddScore_proofImg").attr("src", studentAddScore.proof);
				$("#studentAddScore_shengQingShiJian_edit").val(studentAddScore.shengQingShiJian);
				$("#studentAddScore_shenHeState_edit").val(studentAddScore.shenHeState);
				$("#studentAddScore_shenHeState_edit").validatebox({
					required : true,
					missingMessage : "请输入审核状态",
				});
				$("#studentAddScore_shenHeTime_edit").val(studentAddScore.shenHeTime);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#studentAddScoreModifyButton").click(function(){ 
		if ($("#studentAddScoreEditForm").form("validate")) {
			$("#studentAddScoreEditForm").form({
			    url:"StudentAddScore/" +  $("#studentAddScore_addScoreId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#studentAddScoreEditForm").form("validate"))  {
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
			$("#studentAddScoreEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
