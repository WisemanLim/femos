package com.stephenspoon;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class ActMain extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Intent i = new Intent(this, com.stephenspoon.calendar.ActCalendar.class);
        startActivityForResult(i, 3000);
    }
}