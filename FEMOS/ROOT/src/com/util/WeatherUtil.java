package com.util;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

 
public class WeatherUtil 
{
	
	public static String drawWeather(String XmlUrl) throws Exception
	{
		String responseHtml = "";
		
		DocumentBuilder docBuilder;
	    String xmlData;
	    Document doc;
	    
	    docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();

        URL url = new URL(XmlUrl);
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();

        byte[] bytes = new byte[4096];
        InputStream in = conn.getInputStream();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        while(true){
            int red = in.read(bytes);
            if(red < 0)
                break;
            baos.write(bytes, 0, red);
        }
        xmlData = baos.toString("utf-8");  
        baos.close();
        in.close();
        doc = docBuilder.parse(new InputSource(new StringReader(xmlData)));
        System.out.println(xmlData);
        
        Date dt = new Date();
        int hour = dt.getHours();
        
        // 기상청 xml은 3시간 단위로 예보를 보여줌. 현재시간 기준으로 어떤 예보를 가져올 것인지 정함.
        int hourGubun = 0;
        if (hour == 0 || hour == 1 || hour == 2)
        {
        	hourGubun = 3;
        }
        else if(hour == 3 || hour == 4 || hour == 5)
        {
        	hourGubun = 6;
        }
        else if(hour == 6 || hour == 7 || hour == 8)
        {
        	hourGubun = 9;
        }
        else if(hour == 9 || hour == 10 || hour == 11)
        {
        	hourGubun = 12;
        }
        else if(hour == 12 || hour == 13 || hour == 14)
        {
        	hourGubun = 15;
        }
        else if(hour == 15 || hour == 16 || hour == 17)
        {
        	hourGubun = 18;
        }
        else if(hour == 18 || hour == 19 || hour == 20)
        {
        	hourGubun = 21;
        }
        else if(hour == 21 || hour == 22 || hour == 23)
        {
        	hourGubun = 24;
        }
        
        NodeList data = doc.getElementsByTagName("data");
        
        responseHtml = responseHtml + "<h3>날씨 현황</h3>";
        responseHtml = responseHtml + "<table class='table1' style='width:420px'>";
        responseHtml = responseHtml + "<tr>";
        for (int i = 0; i < data.getLength(); i++)
        {
        	Element data_el = (Element)doc.getElementsByTagName("data").item(i);
    		
        	if(Integer.parseInt(((Element)data_el.getElementsByTagName("hour").item(0)).getTextContent()) == hourGubun)
        	{
        		if(((Element)data_el.getElementsByTagName("day").item(0)).getTextContent().equals("0"))
        		{
        			responseHtml = responseHtml + "<th>오늘</th>";
        			//System.out.println("오늘");
        		}
        		if(((Element)data_el.getElementsByTagName("day").item(0)).getTextContent().equals("1"))
        		{
        			responseHtml = responseHtml + "<th>내일</th>";
        			//System.out.println("내일");
        		}
        		if(((Element)data_el.getElementsByTagName("day").item(0)).getTextContent().equals("2"))
        		{
        			responseHtml = responseHtml + "<th>모레</th>";
        			//System.out.println("모레");
        		}
        	}
        }
        responseHtml = responseHtml + "</tr>";
        
        responseHtml = responseHtml + "<tr>";
        
        for (int i = 0; i < data.getLength(); i++)
        {
        	Element data_el = (Element)doc.getElementsByTagName("data").item(i);
        	
        	if(Integer.parseInt(((Element)data_el.getElementsByTagName("hour").item(0)).getTextContent()) == hourGubun)
        	{
        		responseHtml = responseHtml + "<td>";	
        		
        		if(((Element)data_el.getElementsByTagName("wfKor").item(0)).getTextContent().replaceAll(" ","").equals("맑음"))
        		{
        			responseHtml = responseHtml + "<img src='./img/1.png' alt='맑음'>";
        		}
        		if(((Element)data_el.getElementsByTagName("wfKor").item(0)).getTextContent().replaceAll(" ","").equals("구름많음"))
        		{
        			responseHtml = responseHtml + "<img src='./img/2.png' alt='구름 많음'>";
        		}
        		if(((Element)data_el.getElementsByTagName("wfKor").item(0)).getTextContent().replaceAll(" ","").equals("구름조금"))
        		{
        			responseHtml = responseHtml + "<img src='./img/3.png' alt='구름 조금'>";
        		}
        		if(((Element)data_el.getElementsByTagName("wfKor").item(0)).getTextContent().replaceAll(" ","").equals("흐리고비")||((Element)data_el.getElementsByTagName("wfKor").item(0)).getTextContent().trim().equals("비"))
        		{
        			responseHtml = responseHtml + "<img src='./img/4.png' alt='흐리고 비'>";
        		}
        		if(((Element)data_el.getElementsByTagName("wfKor").item(0)).getTextContent().replaceAll(" ","").equals("눈/비"))
        		{
        			responseHtml = responseHtml + "<img src='./img/5.png' alt='눈/비'>";
        		}
        		responseHtml = responseHtml + "<br><span class='temp1'>";
        		if(((Element)data_el.getElementsByTagName("tmn").item(0)).getTextContent().toString().equals("-999.0"))
        		{
        			responseHtml = responseHtml + "missing";
        		}
        		else
        		{
        			responseHtml = responseHtml + ((Element)data_el.getElementsByTagName("tmn").item(0)).getTextContent() + "℃";
        		}
        		responseHtml = responseHtml + "</span> / <span class='temp2'>";
        		if(((Element)data_el.getElementsByTagName("tmx").item(0)).getTextContent().toString().equals("-999.0"))
        		{
        			responseHtml = responseHtml + "missing";
        		}
        		else
        		{
        			responseHtml = responseHtml + ((Element)data_el.getElementsByTagName("tmx").item(0)).getTextContent() + "℃";
        		}
        		responseHtml = responseHtml + "</span>";
        		responseHtml = responseHtml + "";
        		responseHtml = responseHtml + "</td>";	
        	}
        }
        
        responseHtml = responseHtml + "</tr>";
        
        responseHtml = responseHtml + "</table>";
        
        return responseHtml;

	}
	
	public static String drawWeekWeather(String XmlUrl) throws Exception
	{
		String responseHtml = "";
		
		DocumentBuilder docBuilder;
	    String xmlData;
	    Document doc;
	    
	    docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();

        URL url = new URL(XmlUrl);
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();

        byte[] bytes = new byte[4096];
        InputStream in = conn.getInputStream();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        while(true){
            int red = in.read(bytes);
            if(red < 0)
                break;
            baos.write(bytes, 0, red);
        }
        xmlData = baos.toString("utf-8");  
        baos.close();
        in.close();
        doc = docBuilder.parse(new InputSource(new StringReader(xmlData)));
        //System.out.println(xmlData);

        // 여기까지 진행이 되면 xml 파싱은 끝이 나며 doc에는 DOM 형태의 문서 구조를 갖는다.

        // 이제 DOM 을 파싱해보자.
        
        // 제목
        String title = doc.getElementsByTagName("title").item(0).getTextContent();
        
        //요약내용
        String wf = doc.getElementsByTagName("wf").item(0).getTextContent();
        
        responseHtml = responseHtml + "<h3>"+title+"</h3>";
        responseHtml = responseHtml + "<div id='weekWeather'>";
        responseHtml = responseHtml + "<div style='border:1px solid #4c727b;padding:10px'>" + wf + "</div>";
       
        NodeList locationNodes = doc.getElementsByTagName("location");
        
        for(int i = 0; i < locationNodes.getLength(); i++)
        {
        	Element el = (Element)doc.getElementsByTagName("location").item(i);
        	String province = ((Element)el.getElementsByTagName("province").item(0)).getTextContent();
        	String city  = ((Element)el.getElementsByTagName("city").item(0)).getTextContent();
        	
        	responseHtml = responseHtml + "<div style='margin-top:10px'>";
        	responseHtml = responseHtml + "<h3>"+city+"</h3>";
        	
        	responseHtml = responseHtml + "<table  class='table1'>";
        	responseHtml = responseHtml + "<colgroup>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "<col width='80'/>";
        	responseHtml = responseHtml + "</colgroup>";
        	
        	responseHtml = responseHtml + "<tr>";
        	for(int j = 0; j < el.getElementsByTagName("data").getLength(); j++)
        	{
        		Element data_el = (Element)doc.getElementsByTagName("data").item(j);
            	
        		String numEf = ((Element)data_el.getElementsByTagName("numEf").item(0)).getTextContent();
        		String tmEf = ((Element)data_el.getElementsByTagName("tmEf").item(0)).getTextContent();
        		String sub_wf = ((Element)data_el.getElementsByTagName("wf").item(0)).getTextContent();
        		String tmn = ((Element)data_el.getElementsByTagName("tmn").item(0)).getTextContent();
        		String tmx = ((Element)data_el.getElementsByTagName("tmx").item(0)).getTextContent();
        		String reliability = ((Element)data_el.getElementsByTagName("reliability").item(0)).getTextContent();
        		
        		responseHtml = responseHtml + "<th>("+tmEf+")</th>";
        		
        	}
        	responseHtml = responseHtml + "</tr>";
        	
        	responseHtml = responseHtml + "<tr>";
        	for(int j = 0; j < el.getElementsByTagName("data").getLength(); j++)
        	{
        		Element data_el = (Element)doc.getElementsByTagName("data").item(j);
            	
        		String numEf = ((Element)data_el.getElementsByTagName("numEf").item(0)).getTextContent();
        		String tmEf = ((Element)data_el.getElementsByTagName("tmEf").item(0)).getTextContent();
        		String sub_wf = ((Element)data_el.getElementsByTagName("wf").item(0)).getTextContent();
        		String tmn = ((Element)data_el.getElementsByTagName("tmn").item(0)).getTextContent();
        		String tmx = ((Element)data_el.getElementsByTagName("tmx").item(0)).getTextContent();
        		String reliability = ((Element)data_el.getElementsByTagName("reliability").item(0)).getTextContent();
        		String wf_img = "";
        		
        		if(sub_wf.replaceAll(" ","").equals("맑음"))
        		{
        			wf_img =  "<img src='./img/1.png' alt='맑음'>";
        		}
        		if(sub_wf.replaceAll(" ","").equals("구름많음"))
        		{
        			wf_img =  "<img src='./img/2.png' alt='구름 많음'>";
        		}
        		if(sub_wf.replaceAll(" ","").equals("구름조금"))
        		{
        			wf_img =  "<img src='./img/3.png' alt='구름 조금'>";
        		}
        		if(sub_wf.replaceAll(" ","").equals("흐리고비")||sub_wf.equals("비"))
        		{
        			wf_img =  "<img src='./img/4.png' alt='흐리고 비'>";
        		}
        		if(sub_wf.replaceAll(" ","").equals("눈/비"))
        		{
        			wf_img =  "<img src='./img/5.png' alt='눈/비'>";
        		}
        		responseHtml = responseHtml + "<td>"+wf_img+" <p class='temp'> <span class='temp1'>"+tmn+"℃</span> <span class='temp2'>"+tmx+"℃</span></p>신뢰도 : "+reliability+"</td>";
        		
        	}
        	responseHtml = responseHtml + "</tr>";
        	
        	responseHtml = responseHtml + "</table>";
        	
        	responseHtml = responseHtml + "</div>";
        	responseHtml = responseHtml + "</div>";
        }
       
        
        return responseHtml;

	}

}
