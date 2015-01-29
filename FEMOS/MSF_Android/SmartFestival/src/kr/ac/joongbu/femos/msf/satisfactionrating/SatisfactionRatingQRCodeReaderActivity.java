package kr.ac.joongbu.femos.msf.satisfactionrating;

import kr.ac.joongbu.femos.core.QRCodeReaderActivity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;


public class SatisfactionRatingQRCodeReaderActivity extends QRCodeReaderActivity {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

	@Override
	protected void onGetQRCodeContents(String contents) {
		Toast.makeText(this, contents, Toast.LENGTH_LONG).show();
		goWebpage(contents);
	}
	
	private void goWebpage(String url) {
		Intent intent = new Intent(SatisfactionRatingQRCodeReaderActivity.this, SatisfactionRatingActivity.class);
		intent.putExtra(SatisfactionRatingActivity.INIT_URL, url);
		startActivity(intent);
		finish();
	}
}