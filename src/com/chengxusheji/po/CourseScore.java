package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class CourseScore {
    /*成绩id*/
    private Integer scoreId;
    public Integer getScoreId(){
        return scoreId;
    }
    public void setScoreId(Integer scoreId){
        this.scoreId = scoreId;
    }

    /*学生*/
    private Student studentObj;
    public Student getStudentObj() {
        return studentObj;
    }
    public void setStudentObj(Student studentObj) {
        this.studentObj = studentObj;
    }

    /*课程*/
    private Course courseObj;
    public Course getCourseObj() {
        return courseObj;
    }
    public void setCourseObj(Course courseObj) {
        this.courseObj = courseObj;
    }

    /*成绩*/
    @NotNull(message="必须输入成绩")
    private Float score;
    public Float getScore() {
        return score;
    }
    public void setScore(Float score) {
        this.score = score;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCourseScore=new JSONObject(); 
		jsonCourseScore.accumulate("scoreId", this.getScoreId());
		jsonCourseScore.accumulate("studentObj", this.getStudentObj().getStudentName());
		jsonCourseScore.accumulate("studentObjPri", this.getStudentObj().getStudentNumber());
		jsonCourseScore.accumulate("courseObj", this.getCourseObj().getCourseName());
		jsonCourseScore.accumulate("courseObjPri", this.getCourseObj().getCourseNo());
		jsonCourseScore.accumulate("score", this.getScore());
		return jsonCourseScore;
    }}