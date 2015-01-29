package kr.ac.joongbu.femos.msf.guestcheck;

import kr.ac.joongbu.femos.core.WebViewActivity;
import android.content.SharedPreferences;
import android.os.Bundle;


public class GuestCheckActivity extends WebViewActivity {
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		String checkUrl = "http://hbsys98.vps.phps.kr/mobile/view_festival.jsp";
		
		SharedPreferences sharedPrefs = getSharedPreferences("JoinInfo", MODE_PRIVATE);
		String visitorId = sharedPrefs.getString("visitorId", null);
		if (visitorId != null) {
			checkUrl += "?visiterId=";
			checkUrl += visitorId;
		}
		
		setDefaultURL(checkUrl);
		super.onCreate(savedInstanceState);
	}
}
