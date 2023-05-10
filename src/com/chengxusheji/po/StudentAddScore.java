package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class StudentAddScore {
    /*加分id*/
    private Integer addScoreId;
    public Integer getAddScoreId(){
        return addScoreId;
    }
    public void setAddScoreId(Integer addScoreId){
        this.addScoreId = addScoreId;
    }

    /*学生*/
    private Student studenObj;
    public Student getStudenObj() {
        return studenObj;
    }
    public void setStudenObj(Student studenObj) {
        this.studenObj = studenObj;
    }

    /*加分项目*/
    private AddScoreItem addScoreObj;
    public AddScoreItem getAddScoreObj() {
        return addScoreObj;
    }
    public void setAddScoreObj(AddScoreItem addScoreObj) {
        this.addScoreObj = addScoreObj;
    }

    /*证明材料*/
    private String proof;
    public String getProof() {
        return proof;
    }
    public void setProof(String proof) {
        this.proof = proof;
    }

    /*申请时间*/
    private String shengQingShiJian;
    public String getShengQingShiJian() {
        return shengQingShiJian;
    }
    public void setShengQingShiJian(String shengQingShiJian) {
        this.shengQingShiJian = shengQingShiJian;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHeState;
    public String getShenHeState() {
        return shenHeState;
    }
    public void setShenHeState(String shenHeState) {
        this.shenHeState = shenHeState;
    }

    /*审核时间*/
    private String shenHeTime;
    public String getShenHeTime() {
        return shenHeTime;
    }
    public void setShenHeTime(String shenHeTime) {
        this.shenHeTime = shenHeTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonStudentAddScore=new JSONObject(); 
		jsonStudentAddScore.accumulate("addScoreId", this.getAddScoreId());
		jsonStudentAddScore.accumulate("studenObj", this.getStudenObj().getStudentName());
		jsonStudentAddScore.accumulate("studenObjPri", this.getStudenObj().getStudentNumber());
		jsonStudentAddScore.accumulate("addScoreObj", this.getAddScoreObj().getItemName());
		jsonStudentAddScore.accumulate("addScoreObjPri", this.getAddScoreObj().getItemId());
		jsonStudentAddScore.accumulate("proof", this.getProof());
		jsonStudentAddScore.accumulate("shengQingShiJian", this.getShengQingShiJian());
		jsonStudentAddScore.accumulate("shenHeState", this.getShenHeState());
		jsonStudentAddScore.accumulate("shenHeTime", this.getShenHeTime());
		return jsonStudentAddScore;
    }}