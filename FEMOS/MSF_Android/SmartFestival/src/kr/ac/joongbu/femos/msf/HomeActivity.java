package kr.ac.joongbu.femos.msf;

import kr.ac.joongbu.femos.msf.R;

import kr.ac.joongbu.femos.msf.guestcheck.GuestCheckActivity;
import kr.ac.joongbu.femos.msf.inconveniencereport.CameraActivity;
import kr.ac.joongbu.femos.msf.joinfestival.JoinFestivalActivity;
import kr.ac.joongbu.femos.msf.satisfactionrating.SatisfactionRatingQRCodeReaderActivity;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;


public class HomeActivity extends Activity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home_activity);
        
        findViewById(R.id.join_festival_button).setOnClickListener(menuButtonClickListener);
        findViewById(R.id.join_festival_button).setTag(JoinFestivalActivity.class);
        findViewById(R.id.satisfaction_rating_button).setOnClickListener(menuButtonClickListener);
        findViewById(R.id.satisfaction_rating_button).setTag(SatisfactionRatingQRCodeReaderActivity.class);
        findViewById(R.id.inconvenience_report_button).setOnClickListener(menuButtonClickListener);
        findViewById(R.id.inconvenience_report_button).setTag(CameraActivity.class);
        findViewById(R.id.guest_check).setOnClickListener(menuButtonClickListener);
        findViewById(R.id.guest_check).setTag(GuestCheckActivity.class);
    }
    
    private OnClickListener menuButtonClickListener = new OnClickListener() {
		@Override
		public void onClick(final View v) {
			if (v.getTag() == JoinFestivalActivity.class) {
				SharedPreferences joinInfoPrefs = getSharedPreferences("JoinInfo", MODE_PRIVATE);
				if (joinInfoPrefs.getString("visitorId", null) != null) {
					new AlertDialog.Builder(HomeActivity.this)
					.setTitle("Smart Festival")
				    .setMessage("이미 참여하셨습니다.\n다시 입력하시겠습니까?")
				    .setPositiveButton("네", new AlertDialog.OnClickListener() {
						@Override
						public void onClick(DialogInterface arg0, int arg1) {
							startActivity(new Intent(HomeActivity.this, (Class<?>)v.getTag()));
						}
					})
				    .setNegativeButton("아니오", null)
				    .show();
					
					return;
				}
			}
			else {
				SharedPreferences joinInfoPrefs = getSharedPreferences("JoinInfo", MODE_PRIVATE);
				if (joinInfoPrefs.getString("visitorId", null) == null) {
					new AlertDialog.Builder(HomeActivity.this)
					.setTitle("Smart Festival")
				    .setMessage("먼저, 축제참여를 해주세요.")
				    .setPositiveButton("확인", null)
				    .show();
					
					return;
				}
			}
			
			startActivity(new Intent(HomeActivity.this, (Class<?>)v.getTag()));
		}
	};
	
	@Override
	public void onBackPressed() {
		new AlertDialog.Builder(HomeActivity.this)
		.setTitle("Smart Festival")
	    .setMessage("시스템을 종료합니다. 계속하시겠습니까?")
	    .setPositiveButton("네", new AlertDialog.OnClickListener() {
			@Override
			public void onClick(DialogInterface arg0, int arg1) {
				finish();
			}
		})
	    .setNegativeButton("아니오", null)
	    .show();
	}
}