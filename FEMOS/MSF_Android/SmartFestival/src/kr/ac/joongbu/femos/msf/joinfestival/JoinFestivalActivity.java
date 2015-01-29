package kr.ac.joongbu.femos.msf.joinfestival;

import kr.ac.joongbu.femos.core.WebViewActivity;
import kr.ac.joongbu.femos.core.WebViewActivity.WebViewActivityListener;
import net.htmlparser.jericho.Element;
import net.htmlparser.jericho.Source;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.Bundle;
import android.view.KeyEvent;
import android.webkit.WebView;


public class JoinFestivalActivity extends WebViewActivity implements WebViewActivityListener {
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		setDefaultURL("http://hbsys98.vps.phps.kr/mobile/join_festival_1.jsp");
		super.onCreate(savedInstanceState);
		
		setListener(this);
		addJavascriptInterface(new JavaScriptInterface(), "jsi");
	}
		
	@Override
    public boolean onKeyDown(int keyCode, KeyEvent event) { 
		if (keyCode == KeyEvent.KEYCODE_BACK) {
			finish();
			return true;
		}
		
		return super.onKeyDown(keyCode, event);
    }
	
	@Override
	public void onPageStarted(WebView webView) {	
	}

	@Override
	public void onPageFinished(WebView webView) {
		webView.loadUrl("javascript:window.jsi.checkHtml(document.getElementsByTagName('html')[0].outerHTML);");
	}
	
	private class JavaScriptInterface {
		
		@SuppressWarnings("unused")
		public void checkHtml(String html) {
			Source source = new Source(html);
			source.fullSequentialParse();
			
			Element festivalCd = source.getFirstElement("id", "festival_cd", false);
			Element visitorNm = source.getFirstElement("id", "visiter_nm", false);
			Element visitorSex = source.getFirstElement("id", "sex", false);
			Element visitorHp = source.getFirstElement("id", "hp", false);
			Element visitorEmail = source.getFirstElement("id", "email", false);
			Element visitorId = source.getFirstElement("id", "visiter_id", false);
			
			if (festivalCd != null && visitorNm != null && visitorSex != null &&
				visitorHp != null && visitorEmail != null && visitorId != null) {
				
				SharedPreferences sharedPrefs = getSharedPreferences("JoinInfo", MODE_PRIVATE);
				Editor editor = sharedPrefs.edit();
				editor.putString("festivalCd", festivalCd.getAttributeValue("value"));
				editor.putString("visitorName", visitorNm.getAttributeValue("value"));
				editor.putString("visitorSex", visitorSex.getAttributeValue("value"));
				editor.putString("visitorPhoneNumber", visitorHp.getAttributeValue("value"));
				editor.putString("visitorEmail", visitorEmail.getAttributeValue("value"));
				editor.putString("visitorId", visitorId.getAttributeValue("value"));
				editor.commit();
			}
		}
	}
}
