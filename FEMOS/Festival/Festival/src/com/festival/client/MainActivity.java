package com.festival.client;

import org.apache.cordova.DroidGap;

import android.app.Activity;
import android.os.Bundle;
import android.view.WindowManager;

public class MainActivity extends DroidGap
{
	public static Activity activity;
	
	@Override
	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		activity = this;
		super.loadUrl("file:///android_asset/www/index.html");
		getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
	}
}
