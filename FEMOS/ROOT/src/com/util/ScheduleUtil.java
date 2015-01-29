package com.util;

import java.util.Vector;
import com.plan.schedule.Biz_schedule_plan;
import com.plan.schedule.Dal_schedule_plan;

public class ScheduleUtil 
{
	public static String getScheduleEventItems(String festival_cd,String festival_hall_cd)
	{
		String retStr = "";

		Dal_schedule_plan schedule = new Dal_schedule_plan();
		schedule.getSchedule_list(festival_cd,festival_hall_cd);
		
		Vector v_list = schedule.getV_list();
		
		
		for(int i = 0; i < v_list.size(); i++)
		{
			Biz_schedule_plan obj = (Biz_schedule_plan)v_list.elementAt(i);
			
			if(i > 0)
			{
				retStr = retStr + ",{";
			}
			else
			{
				retStr = retStr + "{";
			}
			
			retStr = retStr + " id:"+obj.getPk_id()+",";
			retStr = retStr + " title:'"+obj.getSchedule_title()+"',";
			
			if(obj.getAll_day_yn().equals("N"))
			{
				retStr = retStr + "allDay: false,";
			}
			
			retStr = retStr + " start:new Date("+Integer.parseInt(obj.getSt_year())+","+(Integer.parseInt(obj.getSt_month())-1)+","+Integer.parseInt(obj.getSt_day())+","+Integer.parseInt(obj.getSt_hour())+","+Integer.parseInt(obj.getSt_minute())+"),";
			retStr = retStr + " end:new Date("+Integer.parseInt(obj.getEd_year())+","+(Integer.parseInt(obj.getEd_month())-1)+","+Integer.parseInt(obj.getEd_day())+","+Integer.parseInt(obj.getEd_hour())+","+Integer.parseInt(obj.getEd_minute())+"),";
			retStr = retStr + " color:'#"+obj.getBg_color()+"',";
			retStr = retStr + " textColor:'#"+obj.getText_color()+"'";
			
			retStr = retStr + "}";
		}
		return retStr;
	}
}
