package com.androidhuman.example.NotificationBuilder;

import android.app.Activity;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class NotificationBuilder extends Activity implements OnClickListener{
    
	private EditText tickerText;
	private EditText contentTitle;
	private EditText contentText;
	private Button registerButton;
	private NotificationManager nm;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        tickerText = (EditText)findViewById(R.id.tickerText);
        contentTitle = (EditText)findViewById(R.id.contentTitle);
        contentText = (EditText)findViewById(R.id.contentText);
        registerButton = (Button)findViewById(R.id.registerNotification);
        
        registerButton.setOnClickListener(this);
    
    }

	public void onClick(View v) {
		
		switch(v.getId()){
		case R.id.registerNotification:
			// Get Notification Service
			nm = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
			
			PendingIntent intent = PendingIntent.getActivity(
					NotificationBuilder.this, 0, 
					new Intent(NotificationBuilder.this, NotificationMessage.class), 0);
			
			String ticker = tickerText.getText().toString();
			String title = contentTitle.getText().toString();
			String text = contentText.getText().toString();
										
			// Create Notification Object
			Notification notification =
				new Notification(android.R.drawable.ic_input_add,
						ticker, System.currentTimeMillis());
			
			notification.setLatestEventInfo(NotificationBuilder.this, 
					title, text, intent);
			
			nm.notify(1234, notification);
			Toast.makeText(NotificationBuilder.this, "Notification Registered.", 
					Toast.LENGTH_SHORT).show();
		break;
		}
		
	}
	
}