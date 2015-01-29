<%@
page import="java.servlet.*,
javax.servlet.http.*,
java.io.*,
java.util.*,
com.lowagie.text.pdf.*,
com.lowagie.text.*"
%><%
		    response.setHeader("Content-Type","image/png"); //다운로드할 파일 형식 결정.
           
            String filename = java.net.URLDecoder.decode(qrDownLoadURL); // 요청페이지 에서 넘어온 파일 경로
                   
            String dFileName= qrDownLoadURL;
           
           String filename2 = new String(filename.getBytes("8859_1"),"euc-kr"); // 파일 이름이 한글일 경우를 처리.
           String path      = "C:\\WORK\\qrcs\\QRCS_v1.0\\WebContent\\QRImage\\FCCC7907-12BE-4DA3-9695-3DF9BED0023B.png";
           //File file = new File(path+filename2);
           File file = new File(path);
           byte b[] = new byte[(int)file.length()];
           
           System.out.println( "size : " + b.length); 
           System.out.println( "filename2 : " + filename2); 
           System.out.println( "path : " + path); 
           
           response.setHeader("Content-Disposition", "attachment;filename=" + new String(dFileName.getBytes("euc-kr")) + ";");
           if (file.isFile())
           {
        	   			response.flushBuffer();
        	    
                       BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
                       BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
                       int read = 0;
                       while ((read = fin.read(b)) != -1){
                                   outs.write(b,0,read);
                       }
                       outs.flush();
                       outs.close();
                       fin.close();
           }
}%>