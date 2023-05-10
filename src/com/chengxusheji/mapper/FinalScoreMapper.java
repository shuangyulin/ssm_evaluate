package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.FinalScore;

public interface FinalScoreMapper {
	/*添加综合成绩信息*/
	public void addFinalScore(FinalScore finalScore) throws Exception;

	/*按照查询条件分页查询综合成绩记录*/
	public ArrayList<FinalScore> queryFinalScore(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有综合成绩记录*/
	public ArrayList<FinalScore> queryFinalScoreList(@Param("where") String where) throws Exception;

	/*按照查询条件的综合成绩记录数*/
	public int queryFinalScoreCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条综合成绩记录*/
	public FinalScore getFinalScore(int scoreId) throws Exception;

	/*更新综合成绩记录*/
	public void updateFinalScore(FinalScore finalScore) throws Exception;

	/*删除综合成绩记录*/
	public void deleteFinalScore(int scoreId) throws Exception;

}
