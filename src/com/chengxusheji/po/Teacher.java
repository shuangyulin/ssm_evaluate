package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Teacher {
    /*用户名*/
    @NotEmpty(message="用户名不能为空")
    private String teacherUserName;
    public String getTeacherUserName(){
        return teacherUserName;
    }
    public void setTeacherUserName(String teacherUserName){
        this.teacherUserName = teacherUserName;
    }

    /*登录密码*/
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String teacherName;
    public String getTeacherName() {
        return teacherName;
    }
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String sex;
    public String getSex() {
        return sex;
    }
    public void setSex(String sex) {
        this.sex = sex;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthday;
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    /*联系电话*/
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonTeacher=new JSONObject(); 
		jsonTeacher.accumulate("teacherUserName", this.getTeacherUserName());
		jsonTeacher.accumulate("password", this.getPassword());
		jsonTeacher.accumulate("teacherName", this.getTeacherName());
		jsonTeacher.accumulate("sex", this.getSex());
		jsonTeacher.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonTeacher.accumulate("telephone", this.getTelephone());
		return jsonTeacher;
    }}