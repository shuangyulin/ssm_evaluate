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
import com.chengxusheji.service.StudentAddScoreService;
import com.chengxusheji.po.StudentAddScore;
import com.chengxusheji.service.AddScoreItemService;
import com.chengxusheji.po.AddScoreItem;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//StudentAddScore管理控制层
@Controller
@RequestMapping("/StudentAddScore")
public class StudentAddScoreController extends BaseController {

    /*业务层对象*/
    @Resource StudentAddScoreService studentAddScoreService;

    @Resource AddScoreItemService addScoreItemService;
    @Resource StudentService studentService;
	@InitBinder("studenObj")
	public void initBinderstudenObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studenObj.");
	}
	@InitBinder("addScoreObj")
	public void initBinderaddScoreObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("addScoreObj.");
	}
	@InitBinder("studentAddScore")
	public void initBinderStudentAddScore(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentAddScore.");
	}
	/*跳转到添加StudentAddScore视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new StudentAddScore());
		/*查询所有的AddScoreItem信息*/
		List<AddScoreItem> addScoreItemList = addScoreItemService.queryAllAddScoreItem();
		request.setAttribute("addScoreItemList", addScoreItemList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "StudentAddScore_add";
	}

	/*客户端ajax方式提交添加学生加分信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated StudentAddScore studentAddScore, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			studentAddScore.setProof(this.handlePhotoUpload(request, "proofFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        studentAddScoreService.addStudentAddScore(studentAddScore);
        message = "学生加分添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询学生加分信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("studenObj") Student studenObj,@ModelAttribute("addScoreObj") AddScoreItem addScoreObj,String shenHeState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (shenHeState == null) shenHeState = "";
		if(rows != 0)studentAddScoreService.setRows(rows);
		List<StudentAddScore> studentAddScoreList = studentAddScoreService.queryStudentAddScore(studenObj, addScoreObj, shenHeState, page);
	    /*计算总的页数和总的记录数*/
	    studentAddScoreService.queryTotalPageAndRecordNumber(studenObj, addScoreObj, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = studentAddScoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentAddScoreService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(StudentAddScore studentAddScore:studentAddScoreList) {
			JSONObject jsonStudentAddScore = studentAddScore.getJsonObject();
			jsonArray.put(jsonStudentAddScore);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学生加分信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<StudentAddScore> studentAddScoreList = studentAddScoreService.queryAllStudentAddScore();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(StudentAddScore studentAddScore:studentAddScoreList) {
			JSONObject jsonStudentAddScore = new JSONObject();
			jsonStudentAddScore.accumulate("addScoreId", studentAddScore.getAddScoreId());
			jsonArray.put(jsonStudentAddScore);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学生加分信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("studenObj") Student studenObj,@ModelAttribute("addScoreObj") AddScoreItem addScoreObj,String shenHeState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (shenHeState == null) shenHeState = "";
		List<StudentAddScore> studentAddScoreList = studentAddScoreService.queryStudentAddScore(studenObj, addScoreObj, shenHeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    studentAddScoreService.queryTotalPageAndRecordNumber(studenObj, addScoreObj, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = studentAddScoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = studentAddScoreService.getRecordNumber();
	    request.setAttribute("studentAddScoreList",  studentAddScoreList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("studenObj", studenObj);
	    request.setAttribute("addScoreObj", addScoreObj);
	    request.setAttribute("shenHeState", shenHeState);
	    List<AddScoreItem> addScoreItemList = addScoreItemService.queryAllAddScoreItem();
	    request.setAttribute("addScoreItemList", addScoreItemList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "StudentAddScore/studentAddScore_frontquery_result"; 
	}

     /*前台查询StudentAddScore信息*/
	@RequestMapping(value="/{addScoreId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer addScoreId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键addScoreId获取StudentAddScore对象*/
        StudentAddScore studentAddScore = studentAddScoreService.getStudentAddScore(addScoreId);

        List<AddScoreItem> addScoreItemList = addScoreItemService.queryAllAddScoreItem();
        request.setAttribute("addScoreItemList", addScoreItemList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("studentAddScore",  studentAddScore);
        return "StudentAddScore/studentAddScore_frontshow";
	}

	/*ajax方式显示学生加分修改jsp视图页*/
	@RequestMapping(value="/{addScoreId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer addScoreId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键addScoreId获取StudentAddScore对象*/
        StudentAddScore studentAddScore = studentAddScoreService.getStudentAddScore(addScoreId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonStudentAddScore = studentAddScore.getJsonObject();
		out.println(jsonStudentAddScore.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学生加分信息*/
	@RequestMapping(value = "/{addScoreId}/update", method = RequestMethod.POST)
	public void update(@Validated StudentAddScore studentAddScore, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String proofFileName = this.handlePhotoUpload(request, "proofFile");
		if(!proofFileName.equals("upload/NoImage.jpg"))studentAddScore.setProof(proofFileName); 


		try {
			studentAddScoreService.updateStudentAddScore(studentAddScore);
			message = "学生加分更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学生加分更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学生加分信息*/
	@RequestMapping(value="/{addScoreId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer addScoreId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  studentAddScoreService.deleteStudentAddScore(addScoreId);
	            request.setAttribute("message", "学生加分删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学生加分删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学生加分记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String addScoreIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = studentAddScoreService.deleteStudentAddScores(addScoreIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学生加分信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("studenObj") Student studenObj,@ModelAttribute("addScoreObj") AddScoreItem addScoreObj,String shenHeState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(shenHeState == null) shenHeState = "";
        List<StudentAddScore> studentAddScoreList = studentAddScoreService.queryStudentAddScore(studenObj,addScoreObj,shenHeState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "StudentAddScore信息记录"; 
        String[] headers = { "加分id","学生","加分项目","证明材料","申请时间","审核状态","审核时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<studentAddScoreList.size();i++) {
        	StudentAddScore studentAddScore = studentAddScoreList.get(i); 
        	dataset.add(new String[]{studentAddScore.getAddScoreId() + "",studentAddScore.getStudenObj().getStudentName(),studentAddScore.getAddScoreObj().getItemName(),studentAddScore.getProof(),studentAddScore.getShengQingShiJian(),studentAddScore.getShenHeState(),studentAddScore.getShenHeTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"StudentAddScore.xls");//filename是下载的xls的名，建议最好用英文 
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
