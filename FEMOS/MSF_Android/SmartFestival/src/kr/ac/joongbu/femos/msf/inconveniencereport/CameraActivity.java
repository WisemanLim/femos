package kr.ac.joongbu.femos.msf.inconveniencereport;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.hardware.Camera;
import android.media.MediaScannerConnection;
import android.media.MediaScannerConnection.MediaScannerConnectionClient;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.util.Log;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;
import android.view.View.OnClickListener;

import kr.ac.joongbu.femos.msf.R;

public class CameraActivity extends Activity {
	private static final String TAG = CameraActivity.class.getSimpleName();
	private static final int IN_SAMPLE_SIZE = 4; // ImageView 설정 이미지 약하게 크기. 1 / 8의 크기로 처리
	private Camera camera;
	private boolean mInProgress;

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.camera_activity);

		SurfaceHolder holder = ((SurfaceView)findViewById(R.id.surface_view)).getHolder();
		holder.addCallback(mSurfaceListener);
		holder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS); // 외부 버퍼를 사용하도록 설정

		findViewById(R.id.shutter).setOnClickListener(mButtonListener);
	}

	// 카메라 미리보기 SurfaceView의 리스너
	@SuppressLint("NewApi")
	private SurfaceHolder.Callback mSurfaceListener = new SurfaceHolder.Callback() {
		public void surfaceCreated(SurfaceHolder holder) {
			// SurfaceView가 생성되면 카메라를 열
			camera = Camera.open();
			camera.setDisplayOrientation(90);
			Log.i(TAG, "Camera opened");
			// SDK1.5에서 setPreviewDisplay이 IO Exception을 throw한다
			try {
				camera.setPreviewDisplay(holder);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		public void surfaceDestroyed(SurfaceHolder holder) {
			camera.release(); // SurfaceView가 삭제되는 시간에 카메라를 개방
			camera = null;
			Log.i(TAG, "Camera released");
		}

		public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
			// 미리보기 크기를 설정
			// Camera.Parameters parameters = camera.getParameters();
			// parameters.setPreviewSize(width, height);
			// camera.setParameters(parameters);
			camera.startPreview();
			Log.i(TAG, "Camera preview started");
		}
	};

	// 버튼을 눌렀을 때 수신기
	private OnClickListener mButtonListener = new OnClickListener() {
		public void onClick(View v) {
			if (camera != null && mInProgress == false) {
				// 이미지 검색을 시작한다. 리스너 설정
				camera.takePicture(mShutterListener, // 셔터 후
						null, // Raw 이미지 생성 후
						mPicutureListener); // JPE 이미지 생성 후
				mInProgress = true;
			}
		}
	};

	private Camera.ShutterCallback mShutterListener = new Camera.ShutterCallback() {
		// 이미지를 처리하기 전에 호출된다.
		public void onShutter() {
			// 셔터 소리 재생 코드 생략
			Log.i(TAG, "onShutter");
		}
	};

	// JPEG 이미지를 생성 후 호출
	private Camera.PictureCallback mPicutureListener = new Camera.PictureCallback() {
		public void onPictureTaken(byte[] data, Camera camera) {
			Log.i(TAG, "Picture Taken");
			if (data != null) {
				Log.i(TAG, "JPEG Picture Taken");

				// 처리하는 이미지의 크기를 축소
				BitmapFactory.Options options = new BitmapFactory.Options();
				options.inSampleSize = IN_SAMPLE_SIZE;
				final Bitmap bitmap1 = BitmapFactory.decodeByteArray(data, 0, data.length, options);
				final Bitmap bitmap = rotate(bitmap1, 90);
				final String bitmapFilePath = getStoreBitmapFilePath();

				try {
					FileOutputStream bitmapFileOutputStream = new FileOutputStream(bitmapFilePath);
					bitmap.compress(CompressFormat.JPEG, 100, bitmapFileOutputStream);
					bitmapFileOutputStream.close();
					scanMediaFile(bitmapFilePath);
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				Log.i(TAG, "Image Size : width(" + bitmap.getWidth() + "), " + "height(" + bitmap.getHeight() + ")");

				// 정지된 프리뷰를 재개
				camera.startPreview();
				// 처리중 플래그를 떨어뜨림
				mInProgress = false;

				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						startWriteReportActivity(bitmap, bitmapFilePath);
					}
				});
			}
		}
	};

	private String getStoreBitmapFilePath() {
		String bitmapStoreFolderPath = Environment.getExternalStorageDirectory().getAbsolutePath() + File.separator + "MSF";
		File bitmapStoreFolder = new File(bitmapStoreFolderPath);
		if (!bitmapStoreFolder.exists()) {
			if (!bitmapStoreFolder.mkdir()) {
				return "";
			}
		}
		return bitmapStoreFolderPath + File.separator + dateToString(new Date(), "yyyy-MM-dd HH-mm-ss") + ".jpg";
	}

	private Bitmap rotate(Bitmap b, int degrees) {
		if (degrees != 0 && b != null) {
			Matrix m = new Matrix();
			m.setRotate(degrees, (float)b.getWidth() / 2, (float)b.getHeight() / 2);
			try {
				Bitmap b2 = Bitmap.createBitmap(b, 0, 0, b.getWidth(), b.getHeight(), m, true);
				if (b != b2) {
					b.recycle();
					b = b2;
				}
			} catch (OutOfMemoryError ex) {
				// We have no memory to rotate. Return the original bitmap.
			}
		}
		return b;
	}

	private void startWriteReportActivity(Bitmap image, String imageUrl) {
		Intent intent = new Intent(this, InconvenienceReportActivity.class);
		InconvenienceReportActivity.CAMERA_IMAGE = image;
		InconvenienceReportActivity.CAMERA_IMAGE_URL = imageUrl;
		// intent.putExtra(InconvenienceReportActivity.NAME_IMAGE, image);
		startActivity(intent);
		finish();
	}

	private String dateToString(Date date, String format) {
		SimpleDateFormat toFormat = new SimpleDateFormat(format);
		return toFormat.format(date);
	}
	
	private void scanMediaFile(String filePath) {
		List<String> filePaths = new ArrayList<String>();
		filePaths.add(filePath);
		scanMediaFiles(filePaths);
	}
	
	private MediaScannerConnection msc;
	private void scanMediaFiles(final List<String> filePaths) {
		if (msc == null || !msc.isConnected()) {
			msc = new MediaScannerConnection(this, new MediaScannerConnectionClient() {
				int count = 0;
				@Override
				public void onScanCompleted(String path, Uri uri) {
					count++;
					if (count == filePaths.size()) {
						msc.disconnect();
					}
				}
				
				@Override
				public void onMediaScannerConnected() {
					count = 0;
					for (String filePath : filePaths) {
						msc.scanFile(filePath, null);
					}
				}
			});
			msc.connect();
		} else {
			for (String filePath : filePaths) {
				msc.scanFile(filePath, null);
			}
		}
	}
}
