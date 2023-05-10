package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Colleage;

public interface ColleageMapper {
	/*添加学院信息信息*/
	public void addColleage(Colleage colleage) throws Exception;

	/*按照查询条件分页查询学院信息记录*/
	public ArrayList<Colleage> queryColleage(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学院信息记录*/
	public ArrayList<Colleage> queryColleageList(@Param("where") String where) throws Exception;

	/*按照查询条件的学院信息记录数*/
	public int queryColleageCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学院信息记录*/
	public Colleage getColleage(String colleageNumber) throws Exception;

	/*更新学院信息记录*/
	public void updateColleage(Colleage colleage) throws Exception;

	/*删除学院信息记录*/
	public void deleteColleage(String colleageNumber) throws Exception;

}
