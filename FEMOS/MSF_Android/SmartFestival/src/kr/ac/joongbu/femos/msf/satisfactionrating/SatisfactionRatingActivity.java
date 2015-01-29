package kr.ac.joongbu.femos.msf.satisfactionrating;

import kr.ac.joongbu.femos.core.WebViewActivity;
import kr.ac.joongbu.femos.core.WebViewActivity.WebViewActivityListener;
import net.htmlparser.jericho.Element;
import net.htmlparser.jericho.Source;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.webkit.WebView;
import android.widget.Button;

import kr.ac.joongbu.femos.msf.R;

public class SatisfactionRatingActivity extends WebViewActivity implements OnClickListener, WebViewActivityListener {
	private boolean isComplete = false;
	private int grade = 1;
	
	private Button btn_05;
	private Button btn_04;
	private Button btn_03;
	private Button btn_02;
	private Button btn_01;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setLayoutId(R.layout.statisfaction_activity);
		super.onCreate(savedInstanceState);
		
		setListener(this);
		addJavascriptInterface(new JavaScriptInterface(), "jsi");
		
		btn_05 = (Button)findViewById(R.id.btn_05);
		btn_04 = (Button)findViewById(R.id.btn_04);
		btn_03 = (Button)findViewById(R.id.btn_03);
		btn_02 = (Button)findViewById(R.id.btn_02);
		btn_01 = (Button)findViewById(R.id.btn_01);
		
		btn_05.setOnClickListener(this);
		btn_04.setOnClickListener(this);
		btn_03.setOnClickListener(this);
		btn_02.setOnClickListener(this);
		btn_01.setOnClickListener(this);
		
		enableButtons(false);
	}
	
	private void enableButtons(boolean enable) {
		btn_05.setEnabled(enable);
		btn_04.setEnabled(enable);
		btn_03.setEnabled(enable);
		btn_02.setEnabled(enable);
		btn_01.setEnabled(enable);
	}

	@Override
	public void onClick(View v) {
		String text = "";
		
		switch (v.getId()) {
		case R.id.btn_05:
			text = "매우불만";
			grade = 1;
			break;
		case R.id.btn_04:
			text = "불만";
			grade = 2;
			break;
		case R.id.btn_03:
			text = "보통";
			grade = 3;
			break;
		case R.id.btn_02:
			text = "만족";
			grade = 4;
			break;
		case R.id.btn_01:
			text = "매우만족";
			grade = 5;
			break;
		}
		
		new AlertDialog.Builder(this)
		.setTitle("Smart Festival")
	    .setMessage("'" + text + "'으로 평가하시겠습니까?")
	    .setPositiveButton("예", listener)
	    .setNegativeButton("아니오", null)
	    .show();
	}
	
	@Override
    public boolean onKeyDown(int keyCode, KeyEvent event) { 
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			finish();
			return true;
		}
		
		return super.onKeyDown(keyCode, event);
    }
	
	private AlertDialog.OnClickListener listener = new AlertDialog.OnClickListener() {
		@Override
		public void onClick(DialogInterface dialog, int which) {
			String evaluateUrl = "http://hbsys98.vps.phps.kr/mobile/satis_check_prc.jsp";
			
			SharedPreferences joinInfoPrefs = getSharedPreferences("JoinInfo", MODE_PRIVATE);
			SharedPreferences halllInfoPrefs = getSharedPreferences("HallInfo", MODE_PRIVATE);
			
			String festivalCd = joinInfoPrefs.getString("festivalCd", null);
			String visitorId = joinInfoPrefs.getString("visitorId", null);
			String hallCd = halllInfoPrefs.getString("hallCd", null);
						
			if (festivalCd != null && visitorId != null && hallCd != null) {
				evaluateUrl += ("?festival_cd=" + festivalCd);
				evaluateUrl += ("&festival_hall_cd=" + hallCd);
				evaluateUrl += ("&visiter_id=" + visitorId);
				evaluateUrl += ("&grade=" + grade);
			}
						
			loadUrl(evaluateUrl);
		}
	};

	@Override
	public void onPageStarted(WebView webView) {
	}

	@Override
	public void onPageFinished(WebView webView) {
		if (isComplete == false)
			webView.loadUrl("javascript:window.jsi.checkHtml(document.getElementsByTagName('html')[0].outerHTML);");
	}
	
	private class JavaScriptInterface {
		
		@SuppressWarnings("unused")
		public void checkHtml(String html) {
			isComplete = true;
			
			Source source = new Source(html);
			source.fullSequentialParse();
			
			Element hallCd = source.getFirstElement("id", "festival_hall_cd", false);
			if (hallCd != null) {
				SharedPreferences sharedPrefs = getSharedPreferences("HallInfo", MODE_PRIVATE);
				Editor editor = sharedPrefs.edit();
				editor.putString("hallCd", hallCd.getAttributeValue("value"));
				editor.commit();
				
				runOnUiThread(new Runnable() {
					public void run() {
						enableButtons(true);		
					}
				});
			}
			else {
				new AlertDialog.Builder(SatisfactionRatingActivity.this)
				.setTitle("Smart Festival")
			    .setMessage("축제 QR코드가 아닙니다.\n다시 스캔하시겠습니까?")
			    .setPositiveButton("네", new AlertDialog.OnClickListener() {
					@Override
					public void onClick(DialogInterface arg0, int arg1) {
						finish();
						startActivity(new Intent(SatisfactionRatingActivity.this, SatisfactionRatingQRCodeReaderActivity.class));
					}
				})
			    .setNegativeButton("아니오", new AlertDialog.OnClickListener() {
					@Override
					public void onClick(DialogInterface arg0, int arg1) {
						finish();
					}
				}).show();
			}
		}
	}
}
