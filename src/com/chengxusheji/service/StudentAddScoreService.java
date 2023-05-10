package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.AddScoreItem;
import com.chengxusheji.po.StudentAddScore;

import com.chengxusheji.mapper.StudentAddScoreMapper;
@Service
public class StudentAddScoreService {

	@Resource StudentAddScoreMapper studentAddScoreMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加学生加分记录*/
    public void addStudentAddScore(StudentAddScore studentAddScore) throws Exception {
    	studentAddScoreMapper.addStudentAddScore(studentAddScore);
    }

    /*按照查询条件分页查询学生加分记录*/
    public ArrayList<StudentAddScore> queryStudentAddScore(Student studenObj,AddScoreItem addScoreObj,String shenHeState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != studenObj &&  studenObj.getStudentNumber() != null  && !studenObj.getStudentNumber().equals(""))  where += " and t_studentAddScore.studenObj='" + studenObj.getStudentNumber() + "'";
    	if(null != addScoreObj && addScoreObj.getItemId()!= null && addScoreObj.getItemId()!= 0)  where += " and t_studentAddScore.addScoreObj=" + addScoreObj.getItemId();
    	if(!shenHeState.equals("")) where = where + " and t_studentAddScore.shenHeState like '%" + shenHeState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return studentAddScoreMapper.queryStudentAddScore(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<StudentAddScore> queryStudentAddScore(Student studenObj,AddScoreItem addScoreObj,String shenHeState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != studenObj &&  studenObj.getStudentNumber() != null && !studenObj.getStudentNumber().equals(""))  where += " and t_studentAddScore.studenObj='" + studenObj.getStudentNumber() + "'";
    	if(null != addScoreObj && addScoreObj.getItemId()!= null && addScoreObj.getItemId()!= 0)  where += " and t_studentAddScore.addScoreObj=" + addScoreObj.getItemId();
    	if(!shenHeState.equals("")) where = where + " and t_studentAddScore.shenHeState like '%" + shenHeState + "%'";
    	return studentAddScoreMapper.queryStudentAddScoreList(where);
    }

    /*查询所有学生加分记录*/
    public ArrayList<StudentAddScore> queryAllStudentAddScore()  throws Exception {
        return studentAddScoreMapper.queryStudentAddScoreList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Student studenObj,AddScoreItem addScoreObj,String shenHeState) throws Exception {
     	String where = "where 1=1";
    	if(null != studenObj &&  studenObj.getStudentNumber() != null && !studenObj.getStudentNumber().equals(""))  where += " and t_studentAddScore.studenObj='" + studenObj.getStudentNumber() + "'";
    	if(null != addScoreObj && addScoreObj.getItemId()!= null && addScoreObj.getItemId()!= 0)  where += " and t_studentAddScore.addScoreObj=" + addScoreObj.getItemId();
    	if(!shenHeState.equals("")) where = where + " and t_studentAddScore.shenHeState like '%" + shenHeState + "%'";
        recordNumber = studentAddScoreMapper.queryStudentAddScoreCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学生加分记录*/
    public StudentAddScore getStudentAddScore(int addScoreId) throws Exception  {
        StudentAddScore studentAddScore = studentAddScoreMapper.getStudentAddScore(addScoreId);
        return studentAddScore;
    }

    /*更新学生加分记录*/
    public void updateStudentAddScore(StudentAddScore studentAddScore) throws Exception {
        studentAddScoreMapper.updateStudentAddScore(studentAddScore);
    }

    /*删除一条学生加分记录*/
    public void deleteStudentAddScore (int addScoreId) throws Exception {
        studentAddScoreMapper.deleteStudentAddScore(addScoreId);
    }

    /*删除多条学生加分信息*/
    public int deleteStudentAddScores (String addScoreIds) throws Exception {
    	String _addScoreIds[] = addScoreIds.split(",");
    	for(String _addScoreId: _addScoreIds) {
    		studentAddScoreMapper.deleteStudentAddScore(Integer.parseInt(_addScoreId));
    	}
    	return _addScoreIds.length;
    }
}
