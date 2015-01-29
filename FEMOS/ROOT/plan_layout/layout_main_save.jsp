<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.*" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*" %> 
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Vector"%>
<%@page import="com.config.db.DBConnection"%>
<%@page import="com.plan.layout.Dal_route_smu"%>
<%@page import="com.util.CharacterSet"%>
<%@page import="org.apache.commons.codec.binary.Base64"%>

<%

	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	Dal_route_smu routeSmu = new Dal_route_smu();

	//-------------------------------------------------------------
	//
	//-------------------------------------------------------------
	String saveType = request.getParameter("saveType");
	String fhCD = request.getParameter("fhCD");
	String smu_imgData = request.getParameter("smu_imgData");
	
	String[] smu_installation = request.getParameter("smu_installation").split(",");
	String[] smu_route = request.getParameter("smu_route").split(",");
	
	String festival_cd = "";
	String festival_hall_cd = "";

	System.out.println( "smu_installation.length :: " + smu_installation.length + "<BR>" );
	System.out.println( "smu_route.length :: " + smu_route.length + "<BR>" );
	System.out.println( "smu_imgData :: " + smu_imgData.substring(23) + "<BR>" );
	System.out.println( "<BR><BR>" );
	

	if( saveType.equals("AllArea") ){
		
		List<List> iList = new ArrayList<List>();
		ArrayList<String> inst = new ArrayList<String>();
		for (int i = 0; i < smu_installation.length; i++) {
			if ((i % 4 == 0) && (i != 0)) {
				out.println("<BR>");
				iList.add(inst);

				inst = new ArrayList<String>();
			}
			out.println(smu_installation[i] + ",");
			inst.add(smu_installation[i]);

			if (i == smu_installation.length - 1) {
				out.println("<BR>");
				iList.add(inst);
			}
		}
		
		for (int i = 0; i < iList.size(); i++) {
			routeSmu.updateBaseFHCD(
					iList.get(i).get(0).toString(), 
					iList.get(i).get(1).toString(),
					Integer.parseInt(iList.get(i).get(2).toString()),
					Integer.parseInt(iList.get(i).get(3).toString())
			);
		}
		
		response.sendRedirect("layout_main.jsp");
		
	}else if( saveType.equals("PartArea") ){
		
		// 건물정보
		if (smu_installation.length > 0) {
			List<List> iList = new ArrayList<List>();
			ArrayList<String> inst = new ArrayList<String>();

			for (int i = 0; i < smu_installation.length; i++) {
				if ((i % 6 == 0) && (i != 0)) {
					out.println("<BR>");
					iList.add(inst);

					inst = new ArrayList<String>();
				}
				out.println(smu_installation[i] + ",");
				inst.add(smu_installation[i]);

				if (i == smu_installation.length - 1) {
					out.println("<BR>");
					iList.add(inst);
				}
				
				//FESTIVAL_CD
				if( i == 1 ){
					festival_cd = smu_installation[i].toString();
				}
				//FESTIVAL_HALL_CD
				if( i == 2 ){
					festival_hall_cd = smu_installation[i].toString();
				}	
			}

			//------------------------------------------------
			//
			//------------------------------------------------
			//
			if (smu_installation.length > 1) {
				routeSmu.deleteInstFHCD( festival_hall_cd );
			}else{
				routeSmu.deleteInstFHCD( fhCD );
			}
			
			if (smu_installation.length > 1) {
				for (int i = 0; i < iList.size(); i++) {
					routeSmu.insertInstData(
							iList.get(i).get(0).toString(), 
							iList.get(i).get(1).toString(),
							iList.get(i).get(2).toString(),
							iList.get(i).get(3).toString(),
							Integer.parseInt(iList.get(i).get(4).toString()),
							Integer.parseInt(iList.get(i).get(5).toString())
					);
				}
			}
	
		}

		// 루트정보
		if (smu_route.length > 0) {
			
			List<List> rList = new ArrayList<List>();
			ArrayList<String> route = new ArrayList<String>();

			for (int i = 0; i < smu_route.length; i++) {
				if ((i % 14 == 0) && (i != 0)) {
					out.println("<BR>");
					rList.add(route);

					route = new ArrayList<String>();
				}
				out.println(smu_route[i] + ",");
				route.add(smu_route[i]);

				if (i == smu_route.length - 1) {
					out.println("<BR>");
					rList.add(route);
				}
			}

			//------------------------------------------------
			//
			//------------------------------------------------
			if (smu_route.length > 1) {
				routeSmu.deleteRouteFHCD( festival_hall_cd );
			}else{
				routeSmu.deleteRouteFHCD( fhCD );
				
			}
			//
			if (smu_route.length > 1) {
				for (int i = 0; i < rList.size(); i++) {
					routeSmu.insertRouteData(
							rList.get(i).get(0).toString(),
							rList.get(i).get(1).toString(), 
							rList.get(i).get(2).toString(),
							Integer.parseInt(rList.get(i).get(3).toString()),
							rList.get(i).get(4).toString(), 
							rList.get(i).get(5).toString(),
							Integer.parseInt(rList.get(i).get(6).toString()),
							Integer.parseInt(rList.get(i).get(7).toString()),
							Integer.parseInt(rList.get(i).get(8).toString()),
							Integer.parseInt(rList.get(i).get(9).toString()),
							Integer.parseInt(rList.get(i).get(10).toString()),
							Integer.parseInt(rList.get(i).get(11).toString()),
							rList.get(i).get(12).toString(),
							"",
							rList.get(i).get(13).toString()
					);
				}
			}
		}
		
		if( smu_imgData.length() > 0 ){
			 
			String path = request.getRealPath("/");
			String fileName = festival_cd +"_"+ festival_hall_cd +".png";
			path = path +"\\plan_layout\\upload\\"+ fileName;
			System.out.println( path );
			
			
		    byte[] imgBytes = Base64.decodeBase64( smu_imgData.substring(23).getBytes() );
			FileOutputStream osf = new FileOutputStream( new File(path) );  
			osf.write(imgBytes);  
			osf.flush();  
			
			routeSmu.updateBaseImgFHCD(festival_hall_cd, festival_cd, fileName);
		}
		
		//out.print("<script type='text/javascript'>alert('저장에 성공하였습니다.');window.location=\"layout_main.jsp\";</script>"); 
		response.sendRedirect("layout_main.jsp");
	}
		

%>
