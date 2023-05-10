package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.CourseScore;

public interface CourseScoreMapper {
	/*添加课程成绩信息*/
	public void addCourseScore(CourseScore courseScore) throws Exception;

	/*按照查询条件分页查询课程成绩记录*/
	public ArrayList<CourseScore> queryCourseScore(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有课程成绩记录*/
	public ArrayList<CourseScore> queryCourseScoreList(@Param("where") String where) throws Exception;

	/*按照查询条件的课程成绩记录数*/
	public int queryCourseScoreCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条课程成绩记录*/
	public CourseScore getCourseScore(int scoreId) throws Exception;

	/*更新课程成绩记录*/
	public void updateCourseScore(CourseScore courseScore) throws Exception;

	/*删除课程成绩记录*/
	public void deleteCourseScore(int scoreId) throws Exception;

}
