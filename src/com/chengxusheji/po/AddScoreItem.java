package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class AddScoreItem {
    /*加分项目id*/
    private Integer itemId;
    public Integer getItemId(){
        return itemId;
    }
    public void setItemId(Integer itemId){
        this.itemId = itemId;
    }

    /*加分项目名称*/
    @NotEmpty(message="加分项目名称不能为空")
    private String itemName;
    public String getItemName() {
        return itemName;
    }
    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    /*加分项目分数*/
    @NotNull(message="必须输入加分项目分数")
    private Float itemScore;
    public Float getItemScore() {
        return itemScore;
    }
    public void setItemScore(Float itemScore) {
        this.itemScore = itemScore;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonAddScoreItem=new JSONObject(); 
		jsonAddScoreItem.accumulate("itemId", this.getItemId());
		jsonAddScoreItem.accumulate("itemName", this.getItemName());
		jsonAddScoreItem.accumulate("itemScore", this.getItemScore());
		return jsonAddScoreItem;
    }}