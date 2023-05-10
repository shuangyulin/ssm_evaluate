package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Course;

import com.chengxusheji.mapper.CourseMapper;
@Service
public class CourseService {

	@Resource CourseMapper courseMapper;
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

    /*添加课程信息记录*/
    public void addCourse(Course course) throws Exception {
    	courseMapper.addCourse(course);
    }

    /*按照查询条件分页查询课程信息记录*/
    public ArrayList<Course> queryCourse(String courseNo,String courseName,String courseType,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!courseNo.equals("")) where = where + " and t_course.courseNo like '%" + courseNo + "%'";
    	if(!courseName.equals("")) where = where + " and t_course.courseName like '%" + courseName + "%'";
    	if(!courseType.equals("")) where = where + " and t_course.courseType like '%" + courseType + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return courseMapper.queryCourse(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Course> queryCourse(String courseNo,String courseName,String courseType) throws Exception  { 
     	String where = "where 1=1";
    	if(!courseNo.equals("")) where = where + " and t_course.courseNo like '%" + courseNo + "%'";
    	if(!courseName.equals("")) where = where + " and t_course.courseName like '%" + courseName + "%'";
    	if(!courseType.equals("")) where = where + " and t_course.courseType like '%" + courseType + "%'";
    	return courseMapper.queryCourseList(where);
    }

    /*查询所有课程信息记录*/
    public ArrayList<Course> queryAllCourse()  throws Exception {
        return courseMapper.queryCourseList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String courseNo,String courseName,String courseType) throws Exception {
     	String where = "where 1=1";
    	if(!courseNo.equals("")) where = where + " and t_course.courseNo like '%" + courseNo + "%'";
    	if(!courseName.equals("")) where = where + " and t_course.courseName like '%" + courseName + "%'";
    	if(!courseType.equals("")) where = where + " and t_course.courseType like '%" + courseType + "%'";
        recordNumber = courseMapper.queryCourseCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取课程信息记录*/
    public Course getCourse(String courseNo) throws Exception  {
        Course course = courseMapper.getCourse(courseNo);
        return course;
    }

    /*更新课程信息记录*/
    public void updateCourse(Course course) throws Exception {
        courseMapper.updateCourse(course);
    }

    /*删除一条课程信息记录*/
    public void deleteCourse (String courseNo) throws Exception {
        courseMapper.deleteCourse(courseNo);
    }

    /*删除多条课程信息信息*/
    public int deleteCourses (String courseNos) throws Exception {
    	String _courseNos[] = courseNos.split(",");
    	for(String _courseNo: _courseNos) {
    		courseMapper.deleteCourse(_courseNo);
    	}
    	return _courseNos.length;
    }
}
