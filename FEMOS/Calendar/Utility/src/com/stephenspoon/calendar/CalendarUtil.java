package com.stephenspoon.calendar;

/*인터넷 여기저기에서 관련 코드를 참고하고 가져다가 만들었는데 어디에서 참고하였는지 출처를 정리하려니 너무 오래전 일이 되어 버렸네요.
 * 자바코드 씨코드 파이썬코드 등등을 참고하여 정리되었습니다. 참고용으로만 사용하시길 바랍니다.
 * 꾸벅.*/
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import android.util.Log;

public class CalendarUtil {

	private static int mDaysInMonth[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	private static int mDaysInMonthLunar[] = {29, 30};

	private static int[][] mSolarHoliday = {{1}, {0}, {1}, {0}, {5}, {6}, {0}, {15}, {0}, {3}, {0}, {25}};
	private static int[][] mLunarHoliday = {{1, 2}, {0}, {0}, {8}, {0}, {0}, {0}, {14, 15, 16}, {0}, {0}, {0}, {30}};
	
	private static final int BYEAR = 1201;
	private static final int NYEAR = 150;
	private static final int NMONTH = 13;

	private static int myday[] = new int[NYEAR];
	private static int mymonth[] = new int[NYEAR];
	private static int mday[] = new int[NMONTH + 1];

	private static Date mSolarDate;
	private static Date mLunarDate;

	//http://appspot-lidaobing.googlecode.com/svn-history/r27/trunk/_third/lunardate.py
	private static long yearInfos[] = {
	             /* encoding:
	             #               b bbbbbbbbbbbb bbbb
	             #       bit#    1 111111000000 0000
	             #               6 543210987654 3210
	             #               . ............ ....
	             #       month#    000000000111
	             #               M 123456789012   L
	             #    b_j = 1 for long month, b_j = 0 for short month
	             #    L is the leap month of the year if 1<=L<=12; NO leap month if L = 0.
	             #    The leap month (if exists) is long one iff M = 1. */
	             0x04bd8,                                       /* 1900 */
	             0x04ae0, 0x0a570, 0x054d5, 0x0d260, 0x0d950,   /* 1905 */
	             0x16554, 0x056a0, 0x09ad0, 0x055d2, 0x04ae0,   /* 1910 */
	             0x0a5b6, 0x0a4d0, 0x0d250, 0x1d255, 0x0b540,   /* 1915 */
	             0x0d6a0, 0x0ada2, 0x095b0, 0x14977, 0x04970,   /* 1920 */
	             0x0a4b0, 0x0b4b5, 0x06a50, 0x06d40, 0x1ab54,   /* 1925 */
	             0x02b60, 0x09570, 0x052f2, 0x04970, 0x06566,   /* 1930 */
	             0x0d4a0, 0x0ea50, 0x06e95, 0x05ad0, 0x02b60,   /* 1935 */
	             0x186e3, 0x092e0, 0x1c8d7, 0x0c950, 0x0d4a0,   /* 1940 */
	             0x1d8a6, 0x0b550, 0x056a0, 0x1a5b4, 0x025d0,   /* 1945 */
	             0x092d0, 0x0d2b2, 0x0a950, 0x0b557, 0x06ca0,   /* 1950 */
	             0x0b550, 0x15355, 0x04da0, 0x0a5d0, 0x14573,   /* 1955 */
	             0x052d0, 0x0a9a8, 0x0e950, 0x06aa0, 0x0aea6,   /* 1960 */
	             0x0ab50, 0x04b60, 0x0aae4, 0x0a570, 0x05260,   /* 1965 */
	             0x0f263, 0x0d950, 0x05b57, 0x056a0, 0x096d0,   /* 1970 */
	             0x04dd5, 0x04ad0, 0x0a4d0, 0x0d4d4, 0x0d250,   /* 1975 */
	             0x0d558, 0x0b540, 0x0b5a0, 0x195a6, 0x095b0,   /* 1980 */
	             0x049b0, 0x0a974, 0x0a4b0, 0x0b27a, 0x06a50,   /* 1985 */
	             0x06d40, 0x0af46, 0x0ab60, 0x09570, 0x04af5,   /* 1990 */
	             0x04970, 0x064b0, 0x074a3, 0x0ea50, 0x06b58,   /* 1995 */
	             0x05ac0, 0x0ab60, 0x096d5, 0x092e0, 0x0c960,   /* 2000 */
	             0x0d954, 0x0d4a0, 0x0da50, 0x07552, 0x056a0,   /* 2005 */
	             0x0abb7, 0x025d0, 0x092d0, 0x0cab5, 0x0a950,   /* 2010 */
	             0x0b4a0, 0x0baa4, 0x0ad50, 0x055d9, 0x04ba0,   /* 2015 */
	             0x0a5b0, 0x15176, 0x052b0, 0x0a930, 0x07954,   /* 2020 */
	             0x06aa0, 0x0ad50, 0x05b52, 0x04b60, 0x0a6e6,   /* 2025 */
	             0x0a4e0, 0x0d260, 0x0ea65, 0x0d530, 0x05aa0,   /* 2030 */
	             0x076a3, 0x096d0, 0x04bd7, 0x04ad0, 0x0a4d0,   /* 2035 */
	             0x1d0b6, 0x0d250, 0x0d520, 0x0dd45, 0x0b5a0,   /* 2040 */
	             0x056d0, 0x055b2, 0x049b0, 0x0a577, 0x0a4b0,   /* 2045 */
	             0x0aa50, 0x1b255, 0x06d20, 0x0ada0             /* 2049 */
	};

	private static Calendar mCal;
	
	public static void init() {
		Calendar cal = Calendar.getInstance();
		CalendarUtil.setCurCal(cal);
	}
	
	public static void setCurCal(Calendar cal) {
		mCal = cal;
	}

	public static void setCurCal(int year, int month, int day) {
		mCal.set(year, month, day);
	}

	public static Calendar getCurCal() {
		return mCal;
	}
	
	//checking leap year
	public static boolean isLeapYear(int year) {
		GregorianCalendar gregoian = new GregorianCalendar();
		return gregoian.isLeapYear(year);
	}
	
	//checking holiday
	public static boolean isHoliday(int y, int m, int d) {
		if (mSolarHoliday[m][0] == d)
			return true;

		Solar2Lunar(y, m, d);
		int lunarMon = mLunarDate.getMonth();
		for (int i = 0; i < mLunarHoliday[lunarMon].length; i++) {
			if (mLunarHoliday[lunarMon][i] == mLunarDate.getDate())
				return true;
		}
		return false;
	}

	public static int compareDate(Calendar cal1, Calendar cal2) {
		cal1.set(Calendar.HOUR_OF_DAY, 0);
		cal1.set(Calendar.MINUTE, 0);
		cal1.set(Calendar.SECOND, 0);
		cal1.set(Calendar.MILLISECOND, 0);

		cal2.set(Calendar.HOUR_OF_DAY, 0);
		cal2.set(Calendar.MINUTE, 0);
		cal2.set(Calendar.SECOND, 0);
		cal2.set(Calendar.MILLISECOND, 0);

		if (cal1.before(cal2))
			return -1;
		if (cal1.after(cal2))
			return 1;
		return 0;
	}

	public static int compareDateTime(Date date1, Date date2) {
		date1.setSeconds(0);
		date2.setSeconds(0);

		if (date1.after(date2))
			return 1;
		if (date1.before(date2))
			return -1;
		return 0;
	}
	
	private static void Solar2Lunar(int y, int m, int d) {
		long offset;
		mSolarDate = new Date();
		mLunarDate = new Date();
		Date SolarFirstDate = new Date();

		mSolarDate.setYear(y);
		mSolarDate.setMonth(m);
		mSolarDate.setDate(d);
		mSolarDate.setHours(0);

		SolarFirstDate.setYear(1900);
		SolarFirstDate.setMonth(0);
		SolarFirstDate.setDate(31);
		SolarFirstDate.setHours(0);

		offset = Solar2Day(mSolarDate, SolarFirstDate);

		if (mSolarDate.getHours() == 23)	// A lunar day begins at 11 p.m.
			offset++;

		Day2Lunar(offset, mLunarDate);
	}
	
	private static long Solar2Day(Date solar, Date solarFirstDate) {
		return (Solar2Day1(solar) - Solar2Day1(solarFirstDate));
	}
	//����: http://colunar.googlecode.com/svn-history/r21/trunk/colunar.c
	// Compute the number of days from the Solar date BYEAR.1.1
	private static long Solar2Day1(Date d) {
		long offset, delta;
		int i;

		delta = d.getYear() - BYEAR;

		if (delta < 0)
			Log.v("[Solar2Day1]", "Internal error: pick a larger constant for BYEAR.");

		offset = delta * 365 + delta / 4 - delta / 100 + delta / 400;
		for (i = 1; i < (d.getMonth() + 1); i++)
			offset += mDaysInMonth[i];

		if (((d.getMonth() + 1) > 2) && isLeapYear(d.getYear()))
			offset++;

		offset += d.getDate() - 1;

		if (((d.getMonth() + 1) == 2) && isLeapYear(d.getYear())) {
			if (d.getDate() > 29)
				Log.v("[Solar2Day1]", "Day out of range.");
		} else if (d.getDate() > mDaysInMonth[(d.getMonth() + 1)]) {
			Log.v("[Solar2Day1]", "Day out of range.");
		}

		return offset;
	}

	private static void Day2Lunar(long offset, Date d) {
		int i, m, nYear, leapMonth;

		nYear = make_yday();
		for (i = 0; i < nYear && offset > 0; i++)
			offset -= myday[i];

		if (offset < 0)
			offset += myday[--i];

		if (i == NYEAR)
			Log.v("[Day2Lunar]", "Year out of range.");

		d.setYear(i + 1900);

		leapMonth = make_mday(i);
		for (m = 1; m <= NMONTH && offset > 0; m++)
			offset -= mday[m];

		if (offset < 0)
			offset += mday[--m];

		if (leapMonth > 0) /* has leap month */
		{
			if (m > leapMonth)
				--m;
		}

		d.setMonth(m - 1);
		d.setDate((int) (offset + 1));
	}
	/* Compute the number of days in each lunar year in the table */
	private static int make_yday() 
	{
	    int year, i, leap;
	    long code;
	    
	    for (year = 0; year < NYEAR; year++)
	    {
	      code = yearInfos[year];
	      leap = (int)(code & 0xf);
	      myday[year] = 0;
	      if (leap != 0)
	      {
	          i = (int)((code >> 16) & 0x1);
	          myday[year] += mDaysInMonthLunar[i];
	      }
	      code >>= 4;
	      for (i = 0; i < NMONTH-1; i++)
	      {
	          myday[year] += mDaysInMonthLunar[(int)(code&0x1)];
	          code >>= 1;
	      }
	      mymonth[year] = 12;
	      if (leap != 0) mymonth[year]++;
	    }
	    return NYEAR;
	}

	/* Compute the days of each month in the given lunar year */
	private static int make_mday(int y)
	{
	    int i, leapMonth;
	    long code;
	    
	    code = yearInfos[y];
	    leapMonth = (int)code & 0xf;
	    
	    code >>= 4;
	    if (leapMonth == 0)	/* leapMonth == 0 means no leap month */
	    {
	    	mday[NMONTH] = 0;
		    for (i = NMONTH-1; i >= 1; i--)
		    {
		    	mday[i] = mDaysInMonthLunar[(int)(code&0x1)];
		    	code >>= 1;
		    }
	    }
	    else
	    {
	    	i = (int)((yearInfos[y] >> 16) & 0x1);
	    	mday[leapMonth+1] = mDaysInMonthLunar[i];
	    	for (i = NMONTH; i >= 1; i--)
	    	{
	    		if (i == leapMonth+1) i--;
	    		mday[i] = mDaysInMonthLunar[(int)(code&0x1)];
	    		code >>= 1;
	    	}
	    }
	    return leapMonth;
	}

}
