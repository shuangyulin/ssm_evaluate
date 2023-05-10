package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Course {
    /*课程编号*/
    @NotEmpty(message="课程编号不能为空")
    private String courseNo;
    public String getCourseNo(){
        return courseNo;
    }
    public void setCourseNo(String courseNo){
        this.courseNo = courseNo;
    }

    /*课程名称*/
    @NotEmpty(message="课程名称不能为空")
    private String courseName;
    public String getCourseName() {
        return courseName;
    }
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    /*课程类型*/
    @NotEmpty(message="课程类型不能为空")
    private String courseType;
    public String getCourseType() {
        return courseType;
    }
    public void setCourseType(String courseType) {
        this.courseType = courseType;
    }

    /*课程学分*/
    @NotNull(message="必须输入课程学分")
    private Float courseScore;
    public Float getCourseScore() {
        return courseScore;
    }
    public void setCourseScore(Float courseScore) {
        this.courseScore = courseScore;
    }

    /*上课老师*/
    @NotEmpty(message="上课老师不能为空")
    private String teacherName;
    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /*课程总学时*/
    @NotNull(message="必须输入课程总学时")
    private Integer courseHour;
    public Integer getCourseHour() {
        return courseHour;
    }
    public void setCourseHour(Integer courseHour) {
        this.courseHour = courseHour;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCourse=new JSONObject(); 
		jsonCourse.accumulate("courseNo", this.getCourseNo());
		jsonCourse.accumulate("courseName", this.getCourseName());
		jsonCourse.accumulate("courseType", this.getCourseType());
		jsonCourse.accumulate("courseScore", this.getCourseScore());
		jsonCourse.accumulate("teacherName", this.getTeacherName());
		jsonCourse.accumulate("courseHour", this.getCourseHour());
		return jsonCourse;
    }}