package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Student {
    /*学号*/
    @NotEmpty(message="学号不能为空")
    private String studentNumber;
    public String getStudentNumber(){
        return studentNumber;
    }
    public void setStudentNumber(String studentNumber){
        this.studentNumber = studentNumber;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*所在班级*/
    private ClassInfo classObj;
    public ClassInfo getClassObj() {
        return classObj;
    }
    public void setClassObj(ClassInfo classObj) {
        this.classObj = classObj;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String studentName;
    public String getStudentName() {
        return studentName;
    }
    public void setStudentName(String studentName) {
        this.studentName = studentName;
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

    /*学生照片*/
    private String studentPhoto;
    public String getStudentPhoto() {
        return studentPhoto;
    }
    public void setStudentPhoto(String studentPhoto) {
        this.studentPhoto = studentPhoto;
    }

    /*联系电话*/
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*邮箱*/
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonStudent=new JSONObject(); 
		jsonStudent.accumulate("studentNumber", this.getStudentNumber());
		jsonStudent.accumulate("password", this.getPassword());
		jsonStudent.accumulate("classObj", this.getClassObj().getClassName());
		jsonStudent.accumulate("classObjPri", this.getClassObj().getClassNumber());
		jsonStudent.accumulate("studentName", this.getStudentName());
		jsonStudent.accumulate("sex", this.getSex());
		jsonStudent.accumulate("birthday", this.getBirthday().length()>19?this.getBirthday().substring(0,19):this.getBirthday());
		jsonStudent.accumulate("studentPhoto", this.getStudentPhoto());
		jsonStudent.accumulate("telephone", this.getTelephone());
		jsonStudent.accumulate("email", this.getEmail());
		return jsonStudent;
    }}