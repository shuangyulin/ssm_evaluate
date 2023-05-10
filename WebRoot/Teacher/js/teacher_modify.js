$(function () {
	$.ajax({
		url : "Teacher/" + $("#teacher_teacherUserName_edit").val() + "/update",
		type : "get",
		data : {
			//teacherUserName : $("#teacher_teacherUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (teacher, response, status) {
			$.messager.progress("close");
			if (teacher) { 
				$("#teacher_teacherUserName_edit").val(teacher.teacherUserName);
				$("#teacher_teacherUserName_edit").validatebox({
					required : true,
					missingMessage : "请输入用户名",
					editable: false
				});
				$("#teacher_password_edit").val(teacher.password);
				$("#teacher_teacherName_edit").val(teacher.teacherName);
				$("#teacher_teacherName_edit").validatebox({
					required : true,
					missingMessage : "请输入姓名",
				});
				$("#teacher_sex_edit").val(teacher.sex);
				$("#teacher_sex_edit").validatebox({
					required : true,
					missingMessage : "请输入性别",
				});
				$("#teacher_birthday_edit").datebox({
					value: teacher.birthday,
					required: true,
					showSeconds: true,
				});
				$("#teacher_telephone_edit").val(teacher.telephone);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#teacherModifyButton").click(function(){ 
		if ($("#teacherEditForm").form("validate")) {
			$("#teacherEditForm").form({
			    url:"Teacher/" +  $("#teacher_teacherUserName_edit").val() + "/update",
			    onSubmit: function(){
					if($("#teacherEditForm").form("validate"))  {
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
			$("#teacherEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
