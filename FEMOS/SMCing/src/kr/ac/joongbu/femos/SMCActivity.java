package kr.ac.joongbu.femos;

import com.phonegap.*;
import android.os.Bundle;

public class SMCActivity extends DroidGap {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        super.loadUrl("file:///android_asset/www/index.html");
    }
}
