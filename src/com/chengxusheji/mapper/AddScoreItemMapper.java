package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.AddScoreItem;

public interface AddScoreItemMapper {
	/*添加加分项目信息*/
	public void addAddScoreItem(AddScoreItem addScoreItem) throws Exception;

	/*按照查询条件分页查询加分项目记录*/
	public ArrayList<AddScoreItem> queryAddScoreItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有加分项目记录*/
	public ArrayList<AddScoreItem> queryAddScoreItemList(@Param("where") String where) throws Exception;

	/*按照查询条件的加分项目记录数*/
	public int queryAddScoreItemCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条加分项目记录*/
	public AddScoreItem getAddScoreItem(int itemId) throws Exception;

	/*更新加分项目记录*/
	public void updateAddScoreItem(AddScoreItem addScoreItem) throws Exception;

	/*删除加分项目记录*/
	public void deleteAddScoreItem(int itemId) throws Exception;

}
