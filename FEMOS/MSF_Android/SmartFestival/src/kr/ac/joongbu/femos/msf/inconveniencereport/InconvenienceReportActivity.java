package kr.ac.joongbu.femos.msf.inconveniencereport;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;

import kr.ac.joongbu.femos.msf.R;

public class InconvenienceReportActivity extends Activity implements OnClickListener {
	public static final String NAME_IMAGE = "NAME_IMAGE";
	public static final String BOUNDARY = "---------------------------8437329539574375435345";
	public static Bitmap CAMERA_IMAGE;
	public static String CAMERA_IMAGE_URL;
	private ImageView iv_image;
	private EditText et_content;
	private Button btn_report;
	private ProgressDialog progressDialog;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.inconvenience_report_activity);
		
		iv_image = (ImageView)findViewById(R.id.iv_image);
		et_content = (EditText)findViewById(R.id.et_content);
		btn_report = (Button)findViewById(R.id.btn_report);
		btn_report.setOnClickListener(this);

		//Bitmap bm = (Bitmap)getIntent().getParcelableExtra(NAME_IMAGE);
		setImage(CAMERA_IMAGE);
	}

	private void setImage(Bitmap bm) {
		iv_image.setImageBitmap(bm);		
	}

	@Override
	public void onClick(View v) {
		switch (v.getId()) {
		case R.id.btn_report:
			String content = et_content.getText().toString(); 
			report(content);
			break;
		}
	}

	@SuppressLint("NewApi")
	private void report(final String content) {
		if (content.isEmpty()) {
			new AlertDialog.Builder(this)
			.setTitle("Smart Festival")
		    .setMessage("메시지를 작성해주세요.")
		    .setPositiveButton("확인", null)
		    .show();
			return;
		} 
		
		progressDialog = new ProgressDialog(InconvenienceReportActivity.this);
		progressDialog.setCancelable(false);
		progressDialog.setMessage("전송중...");
		progressDialog.show();
		
		Thread thread = new Thread(new Runnable() {
			@Override
			public void run() {
				try {
					URL url = new URL("http://hbsys98.vps.phps.kr/mobile/upload_inconvenient.jsp");
					HttpURLConnection connection = (HttpURLConnection)url.openConnection();
					connection.setRequestProperty("Connection", "Keep-Alive");
					connection.setRequestProperty("Content-Type", "multipart/form-data; boundary="+BOUNDARY);
					connection.setRequestMethod("POST");
					connection.setDoOutput(true);
					connection.setDoInput(true);
					connection.setUseCaches(false);
																									
					DataOutputStream os = new DataOutputStream(connection.getOutputStream());
					writeBodyData(os);
					os.close();
					
					BufferedReader rd = new BufferedReader(new InputStreamReader(connection.getInputStream(), "UTF-8"));
					String line = null;
					while ((line = rd.readLine()) != null)
						Log.i("", line);
					rd.close();
										
					showSuccessAlert();
															
				} catch (MalformedURLException e) {
					e.printStackTrace();
					showFailAlert();
				} catch (IOException e) {
					e.printStackTrace();
					showFailAlert();
				}
			}
			
			private void writeBodyData(DataOutputStream os) throws IOException {
				SharedPreferences joinInfoPrefs = getSharedPreferences("JoinInfo", MODE_PRIVATE);
				String festivalCd = joinInfoPrefs.getString("festivalCd", null);
				String visitorId = joinInfoPrefs.getString("visitorId", null);
				
				String boundaryString = "\r\n--" + BOUNDARY + "\r\n";
				String endString = "\r\n--" + BOUNDARY + "--\r\n";
				
				os.writeBytes(boundaryString);
				
				// festival cd
				os.writeBytes("Content-Disposition: form-data; name=\"festival_cd\";\r\n\r\n");
				os.write(festivalCd.getBytes("UTF-8"));
				os.writeBytes(boundaryString);
				
				// visitor id
				os.writeBytes("Content-Disposition: form-data; name=\"visiter_id\";\r\n\r\n");
				os.write(visitorId.getBytes("UTF-8"));
				os.writeBytes(boundaryString);
				
			    // ivt div
				os.writeBytes("Content-Disposition: form-data; name=\"ivt_div\";\r\n\r\n");
				os.write("A7010001".getBytes("UTF-8"));
				os.writeBytes(boundaryString);
				
			    // ivt content
				os.writeBytes("Content-Disposition: form-data; name=\"ivt_content\";\r\n\r\n");
				os.write(content.getBytes("UTF-8"));
				os.writeBytes(boundaryString);
				
				// attach file
				os.writeBytes("Content-Disposition: form-data; name=\"attach_file\"; filename=\"image.jpg\"\r\n");
				os.writeBytes("Content-Type: image/jpeg\r\n\r\n");
				writeImage(os);
				
				os.writeBytes(endString);
				os.flush();
			}
			
			private void writeImage(DataOutputStream os) throws IOException {
				FileInputStream fileInputStream = new FileInputStream(new File(CAMERA_IMAGE_URL));
				int bytesAvailable = fileInputStream.available();
				int maxBufferSize = 1024;
				int bufferSize = Math.min(bytesAvailable, maxBufferSize);
				byte[] buffer = new byte[bufferSize];

				int bytesRead = fileInputStream.read(buffer, 0, bufferSize);
				while (bytesRead > 0) {
					os.write(buffer, 0, bufferSize);
					bytesAvailable = fileInputStream.available(); 
					bufferSize = Math.min(bytesAvailable, maxBufferSize); 
					bytesRead = fileInputStream.read(buffer, 0, bufferSize); 
				} 
				
				fileInputStream.close();
			}
			
			private void showSuccessAlert() {
				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						progressDialog.dismiss();
						progressDialog = null;
						
						new AlertDialog.Builder(InconvenienceReportActivity.this)
						.setTitle("Smart Festival")
					    .setMessage("전송되었습니다.")
					    .setPositiveButton("확인", listener)
					    .show();						
					}
				});
			}
			
			private void showFailAlert() {
				runOnUiThread(new Runnable() {
					@Override
					public void run() {
						progressDialog.dismiss();
						progressDialog = null;
						
						new AlertDialog.Builder(InconvenienceReportActivity.this)
						.setTitle("Smart Festival")
					    .setMessage("전송이 실패되었습니다.\n다시 시도해주세요.")
					    .setPositiveButton("확인", null)
					    .show();						
					}
				});
			}
		});
		
		thread.start();
	}
	
	private AlertDialog.OnClickListener listener = new AlertDialog.OnClickListener() {
		@Override
		public void onClick(DialogInterface dialog, int which) {
			finish();
		}
	};
}
