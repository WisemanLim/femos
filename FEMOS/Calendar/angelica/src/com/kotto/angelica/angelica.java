package com.kotto.angelica;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

public class angelica extends Activity implements OnClickListener 
{
 
	Button btn1 ;
    Button btn2 ;
    Button btn3 ;
    Button btn4 ;
    
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        btn1 = (Button)findViewById( R.id.Button01 ) ;
        btn2 = (Button)findViewById( R.id.Button02 ) ;
        btn3 = (Button)findViewById( R.id.Button03 ) ;
        btn4 = (Button)findViewById( R.id.Button04 ) ;
        
        btn1.setOnClickListener( this ) ;
        btn2.setOnClickListener( this ) ;
        btn3.setOnClickListener( this ) ;
        btn4.setOnClickListener( this ) ;
        
    }

	@Override
	public void onClick(View v) 
	{
		if( v == btn1 )
		{
			startActivity( new Intent( this, type1.class ) ) ; 
		}
		if( v == btn2 )
		{
			gsCalendarDlg dlg = new gsCalendarDlg( this ) ; 
			dlg.show( ) ;
		}
		if( v == btn3 )
		{
			startActivity( new Intent( this, type3.class ) ) ; 
		}
		if( v == btn4 )
		{
			startActivity( new Intent( this, type2.class ) ) ; 
		}
		
	}
	
	
	public class gsCalendarDlg extends Dialog
    {
		
		/// 달력 객체를 상속받아서 날짜를 눌렀을때의 이벤트를 override한다~
		public class myCalendar extends gsCalendar
		{
			public myCalendar(Context context, LinearLayout layout) 
			{
				super(context, layout);
			}

			/// 이녀석을 override했음
			@Override
			public void myClickEvent(int yyyy, int MM, int dd) 
			{
				/// 로그창에 년 월 일을 출력하고
				Log.d( "년 월 일은~", yyyy + "년 " + MM + "월 " + dd + "일" ) ;
				
				/// 달력 팝업을 닫는다.
				gsCalendarDlg.this.cancel( ) ;
				
				super.myClickEvent(yyyy, MM, dd);
			}
		}

		TextView tvs[] ;
		Button btns[] ;
    	
		public gsCalendarDlg( Context context ) 
		{
			
			super(context);
			requestWindowFeature(Window.FEATURE_NO_TITLE);
			setContentView(R.layout.set1);
	        
	        LinearLayout lv = (LinearLayout)findViewById( R.id.calendar_lLayout ) ;
	        
	        tvs = new TextView[3] ;
	        tvs[0] = (TextView)findViewById( R.id.tv1 ) ;
	        tvs[1] = (TextView)findViewById( R.id.tv2 ) ;
	        tvs[2] = (TextView)findViewById( R.id.tv3 ) ;
	        
	        btns = new Button[4] ;
	        btns[0] = (Button)findViewById( R.id.Button01 ) ;
	        btns[1] = (Button)findViewById( R.id.Button02 ) ;
	        btns[2] = (Button)findViewById( R.id.Button03 ) ;
	        btns[3] = (Button)findViewById( R.id.Button04 ) ;
	        
	        myCalendar cal = new myCalendar( context, lv ) ;
	        
	        //cal.setSizePixel( 420, 385 ) ;
	        
	        cal.setControl( btns ) ;
	        cal.setViewTarget( tvs ) ;
	        
	        cal.initCalendar( ) ;
		}
		
    }
	
}