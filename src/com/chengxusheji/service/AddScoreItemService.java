package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.AddScoreItem;

import com.chengxusheji.mapper.AddScoreItemMapper;
@Service
public class AddScoreItemService {

	@Resource AddScoreItemMapper addScoreItemMapper;
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

    /*添加加分项目记录*/
    public void addAddScoreItem(AddScoreItem addScoreItem) throws Exception {
    	addScoreItemMapper.addAddScoreItem(addScoreItem);
    }

    /*按照查询条件分页查询加分项目记录*/
    public ArrayList<AddScoreItem> queryAddScoreItem(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return addScoreItemMapper.queryAddScoreItem(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<AddScoreItem> queryAddScoreItem() throws Exception  { 
     	String where = "where 1=1";
    	return addScoreItemMapper.queryAddScoreItemList(where);
    }

    /*查询所有加分项目记录*/
    public ArrayList<AddScoreItem> queryAllAddScoreItem()  throws Exception {
        return addScoreItemMapper.queryAddScoreItemList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = addScoreItemMapper.queryAddScoreItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取加分项目记录*/
    public AddScoreItem getAddScoreItem(int itemId) throws Exception  {
        AddScoreItem addScoreItem = addScoreItemMapper.getAddScoreItem(itemId);
        return addScoreItem;
    }

    /*更新加分项目记录*/
    public void updateAddScoreItem(AddScoreItem addScoreItem) throws Exception {
        addScoreItemMapper.updateAddScoreItem(addScoreItem);
    }

    /*删除一条加分项目记录*/
    public void deleteAddScoreItem (int itemId) throws Exception {
        addScoreItemMapper.deleteAddScoreItem(itemId);
    }

    /*删除多条加分项目信息*/
    public int deleteAddScoreItems (String itemIds) throws Exception {
    	String _itemIds[] = itemIds.split(",");
    	for(String _itemId: _itemIds) {
    		addScoreItemMapper.deleteAddScoreItem(Integer.parseInt(_itemId));
    	}
    	return _itemIds.length;
    }
}
