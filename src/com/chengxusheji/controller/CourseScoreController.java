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
import com.chengxusheji.service.CourseScoreService;
import com.chengxusheji.po.CourseScore;
import com.chengxusheji.service.CourseService;
import com.chengxusheji.po.Course;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//CourseScore管理控制层
@Controller
@RequestMapping("/CourseScore")
public class CourseScoreController extends BaseController {

    /*业务层对象*/
    @Resource CourseScoreService courseScoreService;

    @Resource CourseService courseService;
    @Resource StudentService studentService;
	@InitBinder("studentObj")
	public void initBinderstudentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentObj.");
	}
	@InitBinder("courseObj")
	public void initBindercourseObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseObj.");
	}
	@InitBinder("courseScore")
	public void initBinderCourseScore(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseScore.");
	}
	/*跳转到添加CourseScore视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new CourseScore());
		/*查询所有的Course信息*/
		List<Course> courseList = courseService.queryAllCourse();
		request.setAttribute("courseList", courseList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "CourseScore_add";
	}

	/*客户端ajax方式提交添加课程成绩信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated CourseScore courseScore, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        courseScoreService.addCourseScore(courseScore);
        message = "课程成绩添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询课程成绩信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("studentObj") Student studentObj,@ModelAttribute("courseObj") Course courseObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)courseScoreService.setRows(rows);
		List<CourseScore> courseScoreList = courseScoreService.queryCourseScore(studentObj, courseObj, page);
	    /*计算总的页数和总的记录数*/
	    courseScoreService.queryTotalPageAndRecordNumber(studentObj, courseObj);
	    /*获取到总的页码数目*/
	    int totalPage = courseScoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseScoreService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(CourseScore courseScore:courseScoreList) {
			JSONObject jsonCourseScore = courseScore.getJsonObject();
			jsonArray.put(jsonCourseScore);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询课程成绩信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<CourseScore> courseScoreList = courseScoreService.queryAllCourseScore();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(CourseScore courseScore:courseScoreList) {
			JSONObject jsonCourseScore = new JSONObject();
			jsonCourseScore.accumulate("scoreId", courseScore.getScoreId());
			jsonArray.put(jsonCourseScore);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询课程成绩信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("studentObj") Student studentObj,@ModelAttribute("courseObj") Course courseObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<CourseScore> courseScoreList = courseScoreService.queryCourseScore(studentObj, courseObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    courseScoreService.queryTotalPageAndRecordNumber(studentObj, courseObj);
	    /*获取到总的页码数目*/
	    int totalPage = courseScoreService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseScoreService.getRecordNumber();
	    request.setAttribute("courseScoreList",  courseScoreList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("studentObj", studentObj);
	    request.setAttribute("courseObj", courseObj);
	    List<Course> courseList = courseService.queryAllCourse();
	    request.setAttribute("courseList", courseList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "CourseScore/courseScore_frontquery_result"; 
	}

     /*前台查询CourseScore信息*/
	@RequestMapping(value="/{scoreId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer scoreId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键scoreId获取CourseScore对象*/
        CourseScore courseScore = courseScoreService.getCourseScore(scoreId);

        List<Course> courseList = courseService.queryAllCourse();
        request.setAttribute("courseList", courseList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("courseScore",  courseScore);
        return "CourseScore/courseScore_frontshow";
	}

	/*ajax方式显示课程成绩修改jsp视图页*/
	@RequestMapping(value="/{scoreId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer scoreId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键scoreId获取CourseScore对象*/
        CourseScore courseScore = courseScoreService.getCourseScore(scoreId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCourseScore = courseScore.getJsonObject();
		out.println(jsonCourseScore.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新课程成绩信息*/
	@RequestMapping(value = "/{scoreId}/update", method = RequestMethod.POST)
	public void update(@Validated CourseScore courseScore, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			courseScoreService.updateCourseScore(courseScore);
			message = "课程成绩更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "课程成绩更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除课程成绩信息*/
	@RequestMapping(value="/{scoreId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer scoreId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  courseScoreService.deleteCourseScore(scoreId);
	            request.setAttribute("message", "课程成绩删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "课程成绩删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条课程成绩记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String scoreIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = courseScoreService.deleteCourseScores(scoreIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出课程成绩信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("studentObj") Student studentObj,@ModelAttribute("courseObj") Course courseObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<CourseScore> courseScoreList = courseScoreService.queryCourseScore(studentObj,courseObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "CourseScore信息记录"; 
        String[] headers = { "成绩id","学生","课程","成绩"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<courseScoreList.size();i++) {
        	CourseScore courseScore = courseScoreList.get(i); 
        	dataset.add(new String[]{courseScore.getScoreId() + "",courseScore.getStudentObj().getStudentName(),courseScore.getCourseObj().getCourseName(),courseScore.getScore() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"CourseScore.xls");//filename是下载的xls的名，建议最好用英文 
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
