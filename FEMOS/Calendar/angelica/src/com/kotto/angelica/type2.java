package com.kotto.angelica;

import com.kotto.angelica.gsCalendar.gsCalendarColorParam;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

public class type2 extends Activity implements OnClickListener 
{
 
	TextView tvs[] ;
	Button btns[] ;
    

	class myGsCalendar extends gsCalendar
	{

		public myGsCalendar(Context context, LinearLayout layout) 
		{
			super(context, layout);
			// TODO Auto-generated constructor stub
		}
		
		@Override
		public void myClickEvent(int yyyy, int MM, int dd) 
		{
			// TODO Auto-generated method stub
			
			cal.redraw( ) ;
			
			cal.applyHoliday( ) ;
			
			/// 선택된 날짜는 배경 이미지를 변경
	        cal.setSelectedDay( type2.this.getResources( ).getDrawable( R.drawable.icon ) ) ;
	        
	        /// 선택된 날짜는 글씨를 변경
	        cal.setSelectedDayTextColor( 0xff009999 ) ;
			
			super.myClickEvent(yyyy, MM, dd);
		}
		
	}
	
	
	myGsCalendar cal ;
	
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
    	super.onCreate(savedInstanceState);
        setContentView(R.layout.set2);
        
        /// 달력을 띄울 대상 레이아웃
        LinearLayout lv = (LinearLayout)findViewById( R.id.calendar_lLayout ) ;
        
        /// 년 월 일 표시할 텍스트뷰
        tvs = new TextView[3] ;
        tvs[0] = (TextView)findViewById( R.id.tv1 ) ;
        tvs[1] = (TextView)findViewById( R.id.tv2 ) ;
        tvs[2] = null ; /// 일은 표시하지 않음
        
        /// 누르면 년 월 일 조절할 버튼
        btns = new Button[4] ;
        btns[0] = null ; // 년도는 조절하지 않음
        btns[1] = null ; // 위와 동일
        btns[2] = (Button)findViewById( R.id.Button03 ) ;
        btns[3] = (Button)findViewById( R.id.Button04 ) ;
        
        /// 달력객체 생성
        cal = new myGsCalendar( this, lv ) ;
        
        /// 색상 설정할 객체 생성
        gsCalendarColorParam cParam = new gsCalendarColorParam( ) ;
        
        cParam.m_cellColor = 0x00000000 ;
        cParam.m_textColor = 0xffffffff ;
        cParam.m_saturdayTextColor = 0xff33ccff ;
        cParam.m_lineColor = 0x99999999 ;
        cParam.m_topCellColor = 0xff003333 ;
        cParam.m_topTextColor = 0xffffffff ;
        cParam.m_topSundayTextColor = 0xffffffff ;
        cParam.m_topSaturdatTextColor = 0xffffffff ;
        
        /// 셋팅한 값으로 색상값 셋~
        cal.setColorParam( cParam ) ;
        
        /// 배경으로 사용할 이미지 얻기
        Drawable img = getResources( ).getDrawable( R.drawable.bg ) ;
        // 배경 이미지 셋~
        cal.setBackground( img ) ;
        
        /// 달력을 띄울 크기 지정
        cal.setCalendarSize( 478, 600 ) ;
        
        /// 최상단은 높이를 35로 준다(전체높이중 한 셀의 높이 600/7한 값에서 35로 변경되니 달력의 총 높이가 줄어든다.)
        cal.setTopCellSize( 35 ) ;
        
        /// 누르면 반응할 버튼들 셋팅
        cal.setControl( btns ) ;
        
        /// 년 월 일을 띄울 텍스트뷰 셋팅
        cal.setViewTarget( tvs ) ;
        
        cal.initCalendar( ) ;
        
        /// 선택된 날짜는 배경 이미지를 변경
        cal.setSelectedDay( getResources( ).getDrawable( R.drawable.icon ) ) ;
        
        /// 선택된 날짜는 글씨를 변경
        cal.setSelectedDayTextColor( 0xff009999 ) ;
        
        ///// 선택된 날짜는 글씨와 배경을 변경
        //cal.setSelectedDay( 0xff000000, 0xffffffff ) ;
        
        /// 3월 24일은 휴일이라고 계산
        cal.addHoliday( 324 ) ;
        
        /// 휴일은 일요일과 같은 글씨색으로 변경한다.
        cal.applyHoliday( ) ;
        
        
        
        
    }


	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		
	}

}