<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.plan.hr.Dal_hr_plan" %>
<%@ page import="com.plan.hr.Biz_hr_plan" %>
<%@page import="com.util.CharacterSet"%>
<%@page import="java.util.*" %>
<%
	String festival_cd = request.getParameter("festival_cd");
	String sch_div = request.getParameter("sch_div")!=null?request.getParameter("sch_div").toString():"HR_NM";
	String sch_val = request.getParameter("sch_val")!=null?CharacterSet.UTF8toKorean(request.getParameter("sch_val").toString()):"";
	
	String where  = "";
	
	where = where + " WHERE FESTIVAL_CD = '"+festival_cd+"'";
	
	if(sch_val.length() > 0)
	{
		if(where.length() > 0)
		{
			where = where + " AND ";
		}
		else
		{
			where = where + " WHERE ";
		}
		
		where = where + sch_div + " like'%"+sch_val+"%' ";
	}
	
	Dal_hr_plan list = new Dal_hr_plan(); 
	list.getHr_list_all(where);
	Vector v_list = list.getV_list();
	
	if(v_list.size() > 0)
	{
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_hr_plan obj = (Biz_hr_plan)v_list.elementAt(i);
			out.print(obj.getPk_no()+"^"+obj.getHr_nm()+"["+obj.getSupport_type_nm()+"]"+"&");
		}
	}
%>
