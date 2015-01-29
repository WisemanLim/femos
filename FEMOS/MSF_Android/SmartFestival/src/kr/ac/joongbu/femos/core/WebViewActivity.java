package kr.ac.joongbu.femos.core;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ProgressDialog;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.view.KeyEvent;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;

import kr.ac.joongbu.femos.msf.R;

@SuppressLint({ "SetJavaScriptEnabled", "NewApi" })
public class WebViewActivity extends Activity {
	public static final String INIT_URL = "LOAD_URL";
	private WebView webView;
	private String defaultURL = "http://www.naver.com";
	private int layoutId;
	private WebViewActivityListener listener = null;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(layoutId == 0 ? R.layout.webview_activity : layoutId);
		initWebView();
	}
	
	protected void setLayoutId(int layoutId) {
		this.layoutId = layoutId;
	}
	
	protected void setDefaultURL(String defualtURL) {
		this.defaultURL = defualtURL;
	}
	
	protected void setListener(WebViewActivityListener listener) {
		this.listener = listener;
	}
	
	protected void addJavascriptInterface(Object obj, String interfaceName) {
		webView.addJavascriptInterface(obj, interfaceName);
	}
	
	protected void loadUrl(String url) {
		webView.loadUrl(url);
	}

	private void initWebView() {
		String defaultURL = getIntent().getStringExtra(INIT_URL);
		if (defaultURL != null && !defaultURL.isEmpty()) {
			this.defaultURL = defaultURL;
		}

		webView = (WebView)findViewById(R.id.web_view);
		webView.getSettings().setJavaScriptEnabled(true);
		webView.getSettings().setSupportMultipleWindows(true);
		webView.getSettings().setUserAgentString("Mozilla/5.0 (Windows; MSIE 6.0; Android 1.6; en-US) AppleWebKit/525.10+ (KHTML, like Gecko) Version/3.0.4 Safari/523.12.2 myKMB/1.0");
		
		webView.setVerticalScrollbarOverlay(true);
		webView.setWebViewClient(webViewClient);
		webView.setWebChromeClient(new WebChromeClient());
		webView.loadUrl(this.defaultURL);
	}
	
	@Override
    public boolean onKeyDown(int keyCode, KeyEvent event) { 
        if ((keyCode == KeyEvent.KEYCODE_BACK) && webView.canGoBack()) { 
        	webView.goBack(); 
            return true; 
        } 
        return super.onKeyDown(keyCode, event);
    }
	
	private WebViewClient webViewClient = new WebViewClient() {
		private ProgressDialog progressDialog;

		@Override
		public void onPageStarted(WebView view, String url, Bitmap favicon) {
			if (listener != null)
				listener.onPageStarted(view);
			
			if (progressDialog == null) {
				progressDialog = new ProgressDialog(WebViewActivity.this);
				progressDialog.setCancelable(false);
				progressDialog.setMessage("웹페이지 로딩중...");
				progressDialog.show();
			}
		}

		@Override
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			view.loadUrl(url);
			return true;
		}

		@Override
		public void onPageFinished(WebView view, String url) {
			if (listener != null)
				listener.onPageFinished(view);
			
			if (progressDialog.isShowing()) {
				progressDialog.dismiss();
				progressDialog = null;
			}
		}

		@Override
		public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
			Toast.makeText(WebViewActivity.this, "웹페이지를 여는 동안에 오류가 발생했습니다.", 3000);
			WebViewActivity.this.finish();
		}
	};
	
	public interface WebViewActivityListener {
		public void onPageStarted(WebView webView);
		public void onPageFinished(WebView webView);
	}
}
