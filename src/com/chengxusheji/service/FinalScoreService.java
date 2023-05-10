package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.Colleage;
import com.chengxusheji.po.ClassInfo;
import com.chengxusheji.po.FinalScore;

import com.chengxusheji.mapper.FinalScoreMapper;
@Service
public class FinalScoreService {

	@Resource FinalScoreMapper finalScoreMapper;
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

    /*添加综合成绩记录*/
    public void addFinalScore(FinalScore finalScore) throws Exception {
    	finalScoreMapper.addFinalScore(finalScore);
    }

    /*按照查询条件分页查询综合成绩记录*/
    public ArrayList<FinalScore> queryFinalScore(Student studentObj,Colleage colleageObj,ClassInfo classObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null  && !studentObj.getStudentNumber().equals(""))  where += " and t_finalScore.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != colleageObj &&  colleageObj.getColleageNumber() != null  && !colleageObj.getColleageNumber().equals(""))  where += " and t_finalScore.colleageObj='" + colleageObj.getColleageNumber() + "'";
    	if(null != classObj &&  classObj.getClassNumber() != null  && !classObj.getClassNumber().equals(""))  where += " and t_finalScore.classObj='" + classObj.getClassNumber() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return finalScoreMapper.queryFinalScore(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<FinalScore> queryFinalScore(Student studentObj,Colleage colleageObj,ClassInfo classObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_finalScore.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != colleageObj &&  colleageObj.getColleageNumber() != null && !colleageObj.getColleageNumber().equals(""))  where += " and t_finalScore.colleageObj='" + colleageObj.getColleageNumber() + "'";
    	if(null != classObj &&  classObj.getClassNumber() != null && !classObj.getClassNumber().equals(""))  where += " and t_finalScore.classObj='" + classObj.getClassNumber() + "'";
    	return finalScoreMapper.queryFinalScoreList(where);
    }

    /*查询所有综合成绩记录*/
    public ArrayList<FinalScore> queryAllFinalScore()  throws Exception {
        return finalScoreMapper.queryFinalScoreList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Student studentObj,Colleage colleageObj,ClassInfo classObj) throws Exception {
     	String where = "where 1=1";
    	if(null != studentObj &&  studentObj.getStudentNumber() != null && !studentObj.getStudentNumber().equals(""))  where += " and t_finalScore.studentObj='" + studentObj.getStudentNumber() + "'";
    	if(null != colleageObj &&  colleageObj.getColleageNumber() != null && !colleageObj.getColleageNumber().equals(""))  where += " and t_finalScore.colleageObj='" + colleageObj.getColleageNumber() + "'";
    	if(null != classObj &&  classObj.getClassNumber() != null && !classObj.getClassNumber().equals(""))  where += " and t_finalScore.classObj='" + classObj.getClassNumber() + "'";
        recordNumber = finalScoreMapper.queryFinalScoreCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取综合成绩记录*/
    public FinalScore getFinalScore(int scoreId) throws Exception  {
        FinalScore finalScore = finalScoreMapper.getFinalScore(scoreId);
        return finalScore;
    }

    /*更新综合成绩记录*/
    public void updateFinalScore(FinalScore finalScore) throws Exception {
        finalScoreMapper.updateFinalScore(finalScore);
    }

    /*删除一条综合成绩记录*/
    public void deleteFinalScore (int scoreId) throws Exception {
        finalScoreMapper.deleteFinalScore(scoreId);
    }

    /*删除多条综合成绩信息*/
    public int deleteFinalScores (String scoreIds) throws Exception {
    	String _scoreIds[] = scoreIds.split(",");
    	for(String _scoreId: _scoreIds) {
    		finalScoreMapper.deleteFinalScore(Integer.parseInt(_scoreId));
    	}
    	return _scoreIds.length;
    }
}
