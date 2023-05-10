package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.StudentAddScore;

public interface StudentAddScoreMapper {
	/*添加学生加分信息*/
	public void addStudentAddScore(StudentAddScore studentAddScore) throws Exception;

	/*按照查询条件分页查询学生加分记录*/
	public ArrayList<StudentAddScore> queryStudentAddScore(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学生加分记录*/
	public ArrayList<StudentAddScore> queryStudentAddScoreList(@Param("where") String where) throws Exception;

	/*按照查询条件的学生加分记录数*/
	public int queryStudentAddScoreCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学生加分记录*/
	public StudentAddScore getStudentAddScore(int addScoreId) throws Exception;

	/*更新学生加分记录*/
	public void updateStudentAddScore(StudentAddScore studentAddScore) throws Exception;

	/*删除学生加分记录*/
	public void deleteStudentAddScore(int addScoreId) throws Exception;

}
