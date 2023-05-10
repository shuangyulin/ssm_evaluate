package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.AddScoreItemService;
import com.chengxusheji.po.AddScoreItem;

//AddScoreItem管理控制层
@Controller
@RequestMapping("/AddScoreItem")
public class AddScoreItemController extends BaseController {

    /*业务层对象*/
    @Resource AddScoreItemService addScoreItemService;

	@InitBinder("addScoreItem")
	public void initBinderAddScoreItem(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("addScoreItem.");
	}
	/*跳转到添加AddScoreItem视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new AddScoreItem());
		return "AddScoreItem_add";
	}

	/*客户端ajax方式提交添加加分项目信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated AddScoreItem addScoreItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        addScoreItemService.addAddScoreItem(addScoreItem);
        message = "加分项目添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询加分项目信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)addScoreItemService.setRows(rows);
		List<AddScoreItem> addScoreItemList = addScoreItemService.queryAddScoreItem(page);
	    /*计算总的页数和总的记录数*/
	    addScoreItemService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = addScoreItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = addScoreItemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(AddScoreItem addScoreItem:addScoreItemList) {
			JSONObject jsonAddScoreItem = addScoreItem.getJsonObject();
			jsonArray.put(jsonAddScoreItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询加分项目信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<AddScoreItem> addScoreItemList = addScoreItemService.queryAllAddScoreItem();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(AddScoreItem addScoreItem:addScoreItemList) {
			JSONObject jsonAddScoreItem = new JSONObject();
			jsonAddScoreItem.accumulate("itemId", addScoreItem.getItemId());
			jsonAddScoreItem.accumulate("itemName", addScoreItem.getItemName());
			jsonArray.put(jsonAddScoreItem);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询加分项目信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<AddScoreItem> addScoreItemList = addScoreItemService.queryAddScoreItem(currentPage);
	    /*计算总的页数和总的记录数*/
	    addScoreItemService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = addScoreItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = addScoreItemService.getRecordNumber();
	    request.setAttribute("addScoreItemList",  addScoreItemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "AddScoreItem/addScoreItem_frontquery_result"; 
	}

     /*前台查询AddScoreItem信息*/
	@RequestMapping(value="/{itemId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer itemId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键itemId获取AddScoreItem对象*/
        AddScoreItem addScoreItem = addScoreItemService.getAddScoreItem(itemId);

        request.setAttribute("addScoreItem",  addScoreItem);
        return "AddScoreItem/addScoreItem_frontshow";
	}

	/*ajax方式显示加分项目修改jsp视图页*/
	@RequestMapping(value="/{itemId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer itemId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键itemId获取AddScoreItem对象*/
        AddScoreItem addScoreItem = addScoreItemService.getAddScoreItem(itemId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonAddScoreItem = addScoreItem.getJsonObject();
		out.println(jsonAddScoreItem.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新加分项目信息*/
	@RequestMapping(value = "/{itemId}/update", method = RequestMethod.POST)
	public void update(@Validated AddScoreItem addScoreItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			addScoreItemService.updateAddScoreItem(addScoreItem);
			message = "加分项目更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "加分项目更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除加分项目信息*/
	@RequestMapping(value="/{itemId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer itemId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  addScoreItemService.deleteAddScoreItem(itemId);
	            request.setAttribute("message", "加分项目删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "加分项目删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条加分项目记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String itemIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = addScoreItemService.deleteAddScoreItems(itemIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出加分项目信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<AddScoreItem> addScoreItemList = addScoreItemService.queryAddScoreItem();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "AddScoreItem信息记录"; 
        String[] headers = { "加分项目id","加分项目名称","加分项目分数"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<addScoreItemList.size();i++) {
        	AddScoreItem addScoreItem = addScoreItemList.get(i); 
        	dataset.add(new String[]{addScoreItem.getItemId() + "",addScoreItem.getItemName(),addScoreItem.getItemScore() + ""});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"AddScoreItem.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
