package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.Course;
import com.chengxusheji.po.CourseScore;

import com.chengxusheji.mapper.CourseScoreMapper;
@Service
public class CourseScoreService {

	@Resource CourseScoreMapper courseScoreMapper;
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

    /*添加课程成绩记录*/
    public void addCourseScore(CourseScore courseScore) throws Exception {
    	courseScoreMapper.addCourseScore(courseScore);
    }

    /*按照查询条件分页查询课程成绩记录*/
    public ArrayList<CourseScore> queryCourseScore(Student studentObj,Course courseObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null  && !studentObj.getStudentNumber().equals(""))  where += " and t_courseScore.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != courseObj &&  courseObj.getCourseNo() != null  && !courseObj.getCourseNo().equals(""))  where += " and t_courseScore.courseObj='" + courseObj.getCourseNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return courseScoreMapper.queryCourseScore(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<CourseScore> queryCourseScore(Student studentObj,Course courseObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_courseScore.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_courseScore.courseObj='" + courseObj.getCourseNo() + "'";
    	return courseScoreMapper.queryCourseScoreList(where);
    }

    /*查询所有课程成绩记录*/
    public ArrayList<CourseScore> queryAllCourseScore()  throws Exception {
        return courseScoreMapper.queryCourseScoreList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Student studentObj,Course courseObj) throws Exception {
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_courseScore.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_courseScore.courseObj='" + courseObj.getCourseNo() + "'";
        recordNumber = courseScoreMapper.queryCourseScoreCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取课程成绩记录*/
    public CourseScore getCourseScore(int scoreId) throws Exception  {
        CourseScore courseScore = courseScoreMapper.getCourseScore(scoreId);
        return courseScore;
    }

    /*更新课程成绩记录*/
    public void updateCourseScore(CourseScore courseScore) throws Exception {
        courseScoreMapper.updateCourseScore(courseScore);
    }

    /*删除一条课程成绩记录*/
    public void deleteCourseScore (int scoreId) throws Exception {
        courseScoreMapper.deleteCourseScore(scoreId);
    }

    /*删除多条课程成绩信息*/
    public int deleteCourseScores (String scoreIds) throws Exception {
    	String _scoreIds[] = scoreIds.split(",");
    	for(String _scoreId: _scoreIds) {
    		courseScoreMapper.deleteCourseScore(Integer.parseInt(_scoreId));
    	}
    	return _scoreIds.length;
    }
}
