package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Colleage;

import com.chengxusheji.mapper.ColleageMapper;
@Service
public class ColleageService {

	@Resource ColleageMapper colleageMapper;
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

    /*添加学院信息记录*/
    public void addColleage(Colleage colleage) throws Exception {
    	colleageMapper.addColleage(colleage);
    }

    /*按照查询条件分页查询学院信息记录*/
    public ArrayList<Colleage> queryColleage(String colleageNumber,String colleageName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!colleageNumber.equals("")) where = where + " and t_colleage.colleageNumber like '%" + colleageNumber + "%'";
    	if(!colleageName.equals("")) where = where + " and t_colleage.colleageName like '%" + colleageName + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return colleageMapper.queryColleage(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Colleage> queryColleage(String colleageNumber,String colleageName) throws Exception  { 
     	String where = "where 1=1";
    	if(!colleageNumber.equals("")) where = where + " and t_colleage.colleageNumber like '%" + colleageNumber + "%'";
    	if(!colleageName.equals("")) where = where + " and t_colleage.colleageName like '%" + colleageName + "%'";
    	return colleageMapper.queryColleageList(where);
    }

    /*查询所有学院信息记录*/
    public ArrayList<Colleage> queryAllColleage()  throws Exception {
        return colleageMapper.queryColleageList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String colleageNumber,String colleageName) throws Exception {
     	String where = "where 1=1";
    	if(!colleageNumber.equals("")) where = where + " and t_colleage.colleageNumber like '%" + colleageNumber + "%'";
    	if(!colleageName.equals("")) where = where + " and t_colleage.colleageName like '%" + colleageName + "%'";
        recordNumber = colleageMapper.queryColleageCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学院信息记录*/
    public Colleage getColleage(String colleageNumber) throws Exception  {
        Colleage colleage = colleageMapper.getColleage(colleageNumber);
        return colleage;
    }

    /*更新学院信息记录*/
    public void updateColleage(Colleage colleage) throws Exception {
        colleageMapper.updateColleage(colleage);
    }

    /*删除一条学院信息记录*/
    public void deleteColleage (String colleageNumber) throws Exception {
        colleageMapper.deleteColleage(colleageNumber);
    }

    /*删除多条学院信息信息*/
    public int deleteColleages (String colleageNumbers) throws Exception {
    	String _colleageNumbers[] = colleageNumbers.split(",");
    	for(String _colleageNumber: _colleageNumbers) {
    		colleageMapper.deleteColleage(_colleageNumber);
    	}
    	return _colleageNumbers.length;
    }
}
