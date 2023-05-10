$(function () {
	$.ajax({
		url : "Course/" + $("#course_courseNo_edit").val() + "/update",
		type : "get",
		data : {
			//courseNo : $("#course_courseNo_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (course, response, status) {
			$.messager.progress("close");
			if (course) { 
				$("#course_courseNo_edit").val(course.courseNo);
				$("#course_courseNo_edit").validatebox({
					required : true,
					missingMessage : "请输入课程编号",
					editable: false
				});
				$("#course_courseName_edit").val(course.courseName);
				$("#course_courseName_edit").validatebox({
					required : true,
					missingMessage : "请输入课程名称",
				});
				$("#course_courseType_edit").val(course.courseType);
				$("#course_courseType_edit").validatebox({
					required : true,
					missingMessage : "请输入课程类型",
				});
				$("#course_courseScore_edit").val(course.courseScore);
				$("#course_courseScore_edit").validatebox({
					required : true,
					validType : "number",
					missingMessage : "请输入课程学分",
					invalidMessage : "课程学分输入不对",
				});
				$("#course_teacherName_edit").val(course.teacherName);
				$("#course_teacherName_edit").validatebox({
					required : true,
					missingMessage : "请输入上课老师",
				});
				$("#course_courseHour_edit").val(course.courseHour);
				$("#course_courseHour_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入课程总学时",
					invalidMessage : "课程总学时输入不对",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#courseModifyButton").click(function(){ 
		if ($("#courseEditForm").form("validate")) {
			$("#courseEditForm").form({
			    url:"Course/" +  $("#course_courseNo_edit").val() + "/update",
			    onSubmit: function(){
					if($("#courseEditForm").form("validate"))  {
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
			$("#courseEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
