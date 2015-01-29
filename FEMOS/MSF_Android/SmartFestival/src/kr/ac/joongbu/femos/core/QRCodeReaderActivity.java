package kr.ac.joongbu.femos.core;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public abstract class QRCodeReaderActivity extends Activity {
    private static final int REQUEST_CODE = 0;

	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        showQRCodeReader();
    }
    
    private void showQRCodeReader() {
    	Intent intent = new Intent("com.google.zxing.client.android.SCAN");
    	intent.putExtra("SCAN_MODE", "QR_CODE_MODE");
    	startActivityForResult(intent, REQUEST_CODE);
    }
    
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    	if (requestCode == REQUEST_CODE) {
			if (resultCode == RESULT_OK) {
				String contents = data.getStringExtra("SCAN_RESULT");
				onGetQRCodeContents(contents);
			} else if (resultCode == RESULT_CANCELED) {
				onCancelReadQRCode();
			}
		}
    }

    protected abstract void onGetQRCodeContents(String contents);

    protected void onCancelReadQRCode() {
    	finish();
	}
}