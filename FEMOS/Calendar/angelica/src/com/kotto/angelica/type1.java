package com.kotto.angelica;

import android.app.Activity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

public class type1 extends Activity 
{
 
	TextView tvs[] ;
	Button btns[] ;
    
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
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
        
        gsCalendar cal = new gsCalendar( this, lv ) ;
        
        //cal.setSizePixel( 420, 385 ) ;
        
        cal.setControl( btns ) ;
        cal.setViewTarget( tvs ) ;
        
        cal.initCalendar( ) ;
        
        
        
    }

}