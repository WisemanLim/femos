package com.stephenspoon.calendar;

import java.util.Calendar;

import com.stephenspoon.R;

import android.app.Activity;
import android.os.Bundle;
import android.widget.GridView;

public class ActCalendar extends Activity {
	GridView mgridView;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.calendar_month);
		
		mgridView = (GridView)findViewById(R.id.gridView);
		
		CalendarUtil.init();
		initCalendar();
	}
	
	private void initCalendar() {
		Calendar curCal = CalendarUtil.getCurCal();
		Calendar cal = (Calendar) curCal.clone();
		cal.set(Calendar.DAY_OF_MONTH, 1);

		CalendarAdapter caladapter = new CalendarAdapter(this, cal);
		mgridView.setAdapter(caladapter);
	}
	
}
