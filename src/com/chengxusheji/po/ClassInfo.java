package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ClassInfo {
    /*班级编号*/
    @NotEmpty(message="班级编号不能为空")
    private String classNumber;
    public String getClassNumber(){
        return classNumber;
    }
    public void setClassNumber(String classNumber){
        this.classNumber = classNumber;
    }

    /*班级名称*/
    @NotEmpty(message="班级名称不能为空")
    private String className;
    public String getClassName() {
        return className;
    }
    public void setClassName(String className) {
        this.className = className;
    }

    /*所在学院*/
    private Colleage colleageObj;
    public Colleage getColleageObj() {
        return colleageObj;
    }
    public void setColleageObj(Colleage colleageObj) {
        this.colleageObj = colleageObj;
    }

    /*班主任*/
    private String banzhuren;
    public String getBanzhuren() {
        return banzhuren;
    }
    public void setBanzhuren(String banzhuren) {
        this.banzhuren = banzhuren;
    }

    /*开办日期*/
    @NotEmpty(message="开办日期不能为空")
    private String startDate;
    public String getStartDate() {
        return startDate;
    }
    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonClassInfo=new JSONObject(); 
		jsonClassInfo.accumulate("classNumber", this.getClassNumber());
		jsonClassInfo.accumulate("className", this.getClassName());
		jsonClassInfo.accumulate("colleageObj", this.getColleageObj().getColleageName());
		jsonClassInfo.accumulate("colleageObjPri", this.getColleageObj().getColleageNumber());
		jsonClassInfo.accumulate("banzhuren", this.getBanzhuren());
		jsonClassInfo.accumulate("startDate", this.getStartDate().length()>19?this.getStartDate().substring(0,19):this.getStartDate());
		return jsonClassInfo;
    }}