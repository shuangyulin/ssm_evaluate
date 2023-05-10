$(function () {
	$.ajax({
		url : "ClassInfo/" + $("#classInfo_classNumber_edit").val() + "/update",
		type : "get",
		data : {
			//classNumber : $("#classInfo_classNumber_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (classInfo, response, status) {
			$.messager.progress("close");
			if (classInfo) { 
				$("#classInfo_classNumber_edit").val(classInfo.classNumber);
				$("#classInfo_classNumber_edit").validatebox({
					required : true,
					missingMessage : "请输入班级编号",
					editable: false
				});
				$("#classInfo_className_edit").val(classInfo.className);
				$("#classInfo_className_edit").validatebox({
					required : true,
					missingMessage : "请输入班级名称",
				});
				$("#classInfo_colleageObj_colleageNumber_edit").combobox({
					url:"Colleage/listAll",
					valueField:"colleageNumber",
					textField:"colleageName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#classInfo_colleageObj_colleageNumber_edit").combobox("select", classInfo.colleageObjPri);
						//var data = $("#classInfo_colleageObj_colleageNumber_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#classInfo_colleageObj_colleageNumber_edit").combobox("select", data[0].colleageNumber);
						//}
					}
				});
				$("#classInfo_banzhuren_edit").val(classInfo.banzhuren);
				$("#classInfo_startDate_edit").datebox({
					value: classInfo.startDate,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#classInfoModifyButton").click(function(){ 
		if ($("#classInfoEditForm").form("validate")) {
			$("#classInfoEditForm").form({
			    url:"ClassInfo/" +  $("#classInfo_classNumber_edit").val() + "/update",
			    onSubmit: function(){
					if($("#classInfoEditForm").form("validate"))  {
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
			$("#classInfoEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
