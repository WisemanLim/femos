package kr.ac.joongbu.femos.ms;

import android.os.Bundle;
import org.apache.cordova.*;

public class MSTapping extends DroidGap
{
    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        // Set by <content src="index.html" /> in config.xml
        super.loadUrl("file:///android_asset/www/checkedSchedule.html");
    }
}