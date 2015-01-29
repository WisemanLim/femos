package com.stephenspoon.calendar;

import java.util.Calendar;

import com.stephenspoon.R;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.TextView;

public class CalendarAdapter extends BaseAdapter {
	private final int MAX_CELL_COUNT = 42;
	
	private Context mctx;
	private LayoutInflater mInflater;
	private Calendar mSavedCal;
	
	private int mDaysInMonth;
	private int mStartPos, mEndPos;
	
	private static final int[] mWeekColor = {R.color.red, R.color.white, R.color.white, R.color.white,
		R.color.white, R.color.white, R.color.blue};

	public CalendarAdapter(Context c, Calendar cal) {
		mctx = c;
		mInflater = (LayoutInflater)mctx.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		mSavedCal = (Calendar)cal.clone();
		//mSavedCal.add(Calendar.MONTH, -1);
		initCalendar(cal);
	}
	
	private void initCalendar(Calendar cal) {
		Calendar tempcal = (Calendar) cal.clone();
		tempcal.add(Calendar.MONTH, 1);
		tempcal.add(Calendar.DATE, -1);
		mDaysInMonth = tempcal.get(Calendar.DATE);
		
		mStartPos = mSavedCal.get(Calendar.DAY_OF_WEEK) - Calendar.SUNDAY;
		if(mStartPos == 7) {
			mStartPos += 7;
		}
		mEndPos = mStartPos + mDaysInMonth - 1;
	}
	
	public int getCount() {					// TODO Auto-generated method stub
		return MAX_CELL_COUNT;
	}

	public Object getItem(int arg0) {		// TODO Auto-generated method stub

		return null;
	}

	public long getItemId(int arg0) {		// TODO Auto-generated method stub	

		return 0;
	}

	public View getView(int arg0, View arg1, ViewGroup arg2) {		// TODO Auto-generated method stub
		View v = arg1;
		if(v==null) {
			v = mInflater.inflate(R.layout.calendar_day_item, arg2, false);
		}
		
		TextView dayitem = (TextView)v.findViewById(R.id.days);
		if(arg0>=mStartPos && arg0<=mEndPos) {
			v.setLayoutParams(new GridView.LayoutParams(67, 65));
			int nDay = getDayFromPosition(arg0);
			Calendar cal = (Calendar) mSavedCal.clone();
			cal.set(Calendar.DATE, nDay);
			dayitem.setText(Integer.toString(nDay));
			boolean bholiday = CalendarUtil.isHoliday(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE));
			if(bholiday==true)
				dayitem.setTextColor(mctx.getResources().getColor(mWeekColor[0]));
			else
				dayitem.setTextColor(mctx.getResources().getColor(mWeekColor[cal.get(Calendar.DAY_OF_WEEK) - Calendar.SUNDAY]));
		}
		else
			dayitem.setText("");
		return v;
	}
	
	private int getDayFromPosition(int pos) {
		return pos - mStartPos + 1;
	}

}
