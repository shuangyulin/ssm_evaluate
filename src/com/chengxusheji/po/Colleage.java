package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Colleage {
    /*学院编号*/
    @NotEmpty(message="学院编号不能为空")
    private String colleageNumber;
    public String getColleageNumber(){
        return colleageNumber;
    }
    public void setColleageNumber(String colleageNumber){
        this.colleageNumber = colleageNumber;
    }

    /*学院名称*/
    @NotEmpty(message="学院名称不能为空")
    private String colleageName;
    public String getColleageName() {
        return colleageName;
    }
    public void setColleageName(String colleageName) {
        this.colleageName = colleageName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonColleage=new JSONObject(); 
		jsonColleage.accumulate("colleageNumber", this.getColleageNumber());
		jsonColleage.accumulate("colleageName", this.getColleageName());
		return jsonColleage;
    }}