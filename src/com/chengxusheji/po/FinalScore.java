package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class FinalScore {
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

    /*学院*/
    private Colleage colleageObj;
    public Colleage getColleageObj() {
        return colleageObj;
    }
    public void setColleageObj(Colleage colleageObj) {
        this.colleageObj = colleageObj;
    }

    /*班级*/
    private ClassInfo classObj;
    public ClassInfo getClassObj() {
        return classObj;
    }
    public void setClassObj(ClassInfo classObj) {
        this.classObj = classObj;
    }

    /*科目成绩折算分*/
    @NotNull(message="必须输入科目成绩折算分")
    private Float courseFinalScore;
    public Float getCourseFinalScore() {
        return courseFinalScore;
    }
    public void setCourseFinalScore(Float courseFinalScore) {
        this.courseFinalScore = courseFinalScore;
    }

    /*各项目加分数*/
    @NotNull(message="必须输入各项目加分数")
    private Float finalAddScore;
    public Float getFinalAddScore() {
        return finalAddScore;
    }
    public void setFinalAddScore(Float finalAddScore) {
        this.finalAddScore = finalAddScore;
    }

    /*总分*/
    @NotNull(message="必须输入总分")
    private Float finalScore;
    public Float getFinalScore() {
        return finalScore;
    }
    public void setFinalScore(Float finalScore) {
        this.finalScore = finalScore;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFinalScore=new JSONObject(); 
		jsonFinalScore.accumulate("scoreId", this.getScoreId());
		jsonFinalScore.accumulate("studentObj", this.getStudentObj().getStudentName());
		jsonFinalScore.accumulate("studentObjPri", this.getStudentObj().getStudentNumber());
		jsonFinalScore.accumulate("colleageObj", this.getColleageObj().getColleageName());
		jsonFinalScore.accumulate("colleageObjPri", this.getColleageObj().getColleageNumber());
		jsonFinalScore.accumulate("classObj", this.getClassObj().getClassName());
		jsonFinalScore.accumulate("classObjPri", this.getClassObj().getClassNumber());
		jsonFinalScore.accumulate("courseFinalScore", this.getCourseFinalScore());
		jsonFinalScore.accumulate("finalAddScore", this.getFinalAddScore());
		jsonFinalScore.accumulate("finalScore", this.getFinalScore());
		return jsonFinalScore;
    }}