<%/* http://hbsys98.vps.phps.kr/statistics/statistics_report.jsp?div_cd=,1005,,,,1006,1002,1003,1004,1007,1008,1009 */ %>
<%@include file="../lib/session_chk.jsp" %>
<%@page import="java.util.Vector" %>
<%@page import="com.util.CharacterSet" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@page import="java.sql.*, javax.sql.*, java.io.*" %>
<%@page import="java.util.HashMap, java.util.Map, java.util.Iterator, java.util.TreeMap" %>
<%@page import="org.apache.commons.math3.stat.descriptive.DescriptiveStatistics" %>
<%@page import="org.apache.commons.math3.stat.Frequency, com.statistics.SVUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=session.getAttribute("FESTIVAL_NM") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="../css/femos_common.css">
<script src="../js/default.js" type="text/javascript"></script>
<script src="../js/common.js" type="text/javascript"></script>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/dragable/jquery-ui.min.js" type="text/javascript" ></script>

<script src="animatedcollapse.js" type="text/javascript">
/***********************************************
* Animated Collapsible DIV- ⓒ Dynamic Drive DHTML code library (www.dynamicdrive.com)
* This notice MUST stay intact for legal use
* Visit Dynamic Drive at http://www.dynamicdrive.com/ for this script and 100s more
***********************************************/
</script>

<!-- 로딩중 화면표시 시작 --> 
<div id="waiting" style="clear:both;padding-top:0px;position:absolute;top:123px;left:161px;width:90%;height:100%;visibility:hidden;background-color:#000;color:#517277;ext-align:center;z-index:1" align="center" valigh="middle"> 
<table height="400px"><tr><td height="400px" valign="middle"><h1>평가보고서 생성중입니다. 잠시만 기다려 주세요...</h1></td></tr></table>
</div> 
<script type="text/javascript"> 
wb = document.body.offsetHeight/2 - waiting.offsetHeight/2 
wp = document.body.offsetWidth/2 -waiting.offsetWidth/2 
waiting.style.top=wb 
waiting.style.left=wp 
waiting.style.visibility="visible" 
</script> 
<!-- 로딩중 화면표시 끝 -->

<style>
.temp{padding:8px}
.temp1{color:#09F}
.temp2{color:#F30}
.t_01{ color:#6FF; font-weight:bold}
</style>
<script type="text/javascript">
$(document).ready(function() {
	setMenu('left_menu_img',2);
	setMenu('menu_img',5);
	
	$(".popup1").draggable
	({ 
		scroll: false,
		ghosting: true,
		opacity: 0.5
	});
});


function show_layout_form(obj_id)
{
	for(var i = 0; i < $(".popup1").length; i++)
	{
		$(".popup1").eq(i).hide();
		$("#"+obj_id).show(500);
	}
}

function hide_layout_form(obj_id)
{
	$("#"+obj_id).hide(500);
}

</script>
</head>
<%
	// http://hbsys98.vps.phps.kr/statistics/statistics_report.jsp?div_cd=,1005,,,,1006,1002,1003,1004,1007,1008,1009
	String div_cd = request.getParameter("div_cd")!=null?request.getParameter("div_cd"):"";
	String divCd[] = null;
	String tDivCd = "";
	Map<String, Map> svQItem = new HashMap<String, Map>();
	Map<String, Map> svAResult = new HashMap<String, Map>();
	Map<String, Map> svUserInfo = new HashMap<String, Map>();
	int divList = 0;
	
	if ( div_cd.length() > 0 ) {
		divCd = div_cd.split(",");
		divList = divCd.length;
/* 		out.println("Wiseman.Lim--> [" + divCd.length + "]<br/>");
		for ( int i=0; i<divList; i++ ) {
			out.println("--> " + i + "[" + divCd[i] + "]<br/>");
		}*/
	}
	
	if ( divList == 12 ) {
%>
<%
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@hbsys98.vps.phps.kr:1521:FEMOS", "hbsys" , "hbsys2012");
		
		String query = ""; // "select * from sv_user_info where rownum <= ? ";
		PreparedStatement pstmt = null;
%>
<body>
<form id="form1" method="post" action="">
<!--  Highcharts -->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>

<div id="allwrap">
    <div id="header">
        <%@include file="../include/top.jsp" %>
    </div>
    <!--// id="header"-->
    <div id="leftmenu">
       <%@include file="../include/left.jsp" %>
    </div>
    <!--// id="leftmenu"-->
    
    <div id="bodywrap">
        <div id="topmenu">
            <%@include file="../include/oper_top.jsp" %>
        </div>
        <!--// id="topmenu"-->
        <div id="contents"> 
            <div class="contitle">
                <h1>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'2012 안성세계 민속축전'의 평가보고서</h1>
            </div>
            
 			<div class="contents1">
                <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. 종합적인 축제 평가의 체계</h2><br/>
				<h3>
					<font color="red">** '다면평가시스템의 도입 - 축제평가체계' 참조</font><br/><br/>
					축제평가체계에는 평가주체, 평가방법, 평가시기, 평가항목과 기준 등이 주요 구성요소로 나타났다.<br/><br/>
					(1)평가주체는 방문객, 외부 전문가, 지역주민, 주최자 등 네 집단이 평가 주체로 나타났으며, 
					각 집단별로 설문조사를 통한 항목을 위주로 분석하였다.<br/>
					각 평가주체별 항목은 아래에서 나열하도록 하겠다.<br/><br/>
					(2)평가방법은 설문조사, 참여관찰, 데이터 조사, 경제적 영향평가, 심층면접 등의 평가방법이 나타났다.<br/> 
					하지만 본 FEMOS에서는 평가방법은 설문조사에 따른 통계 결과를 입력하여 분석하였다.<br/><br/>
					(3)평가시기에는 사전평가, 실행평가, 사후평가가 있으며, 
					평가시기는 평가주체별 사전/실행/사후에 따라 설문항목으로 나눠 조사한뒤 결과를 분석하였다.
				</h3>
            </div>
            
<%
		// 데이터를 맵으로 구성
		for ( int i=0; i<divList; i++ ) {
			tDivCd = divCd[i];
			if ( !tDivCd.equalsIgnoreCase("") ) {
				// 설문문항 정보
				query = "SELECT /*Q_NUM*/REC_NUM AS KEY, Q_TEXT AS VALUE "
					  + "FROM SV_Q_ITEM "
					  + "WHERE SV_ID = ? "
					  + "ORDER BY SV_ID ASC, REC_NUM ASC ";
				
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, tDivCd);
				
				ResultSet rset = pstmt.executeQuery();
				
				String key = "";
				String value = "";
				Map<String, String> svQItemD = new HashMap<String, String>();
				
				while (rset.next()) {
					key = rset.getString("key");
					value = rset.getString("value");
					svQItemD.put(key, value);
				}
				rset.close();
				pstmt.close();
				
				svQItem.put(tDivCd, svQItemD);
			}
		}
%>
 			<div class="contents1">
                <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. 다면 평가시스템에 의한 집단별 평가항목과 기준</h2><br/>
				<h3>
					*평가항목과 기준은 다음과 같이 상세하게 나열하였다.&nbsp;&nbsp;
					<a href="javascript:collapseQ.slideit();">[상세내용 Show/Hide]</a>
				</h3>
                <div id="question" style="width:800px;">
<%
		// 구성된 맵데이터 화면에 노출하기
		String stepOne = "";
		String stepTwo = "";
		for ( int i=0; i<divList; i++ ) {
			switch ( i ) {
				case 0 : stepOne = "방문객"; stepTwo = "사전평가"; break;
				case 1 : stepOne = "방문객"; stepTwo = "실행평가"; break;
				case 2 : stepOne = "방문객"; stepTwo = "사후평가"; break;
				case 3 : stepOne = "지역주민"; stepTwo = "사전평가"; break;
				case 4 : stepOne = "지역주민"; stepTwo = "실행평가"; break;
				case 5 : stepOne = "지역주민"; stepTwo = "사후평가"; break;
				case 6 : stepOne = "주최자"; stepTwo = "사전평가"; break;
				case 7 : stepOne = "주최자"; stepTwo = "실행평가"; break;
				case 8 : stepOne = "주최자"; stepTwo = "사후평가"; break;
				case 9 : stepOne = "전문가"; stepTwo = "사전평가"; break;
				case 10 : stepOne = "전문가"; stepTwo = "실행평가"; break;
				case 11 : stepOne = "전문가"; stepTwo = "사후평가"; break;
			}
			
			if ( i == 0 || i == 3 || i == 6 || i == 9 ) {
%>
				<br/><br/>
                <table  class="table1">
                	<colgroup>
                		<col width="430px"/>
                		<col width="*"/>
                	</colgroup>
                	<tr>
                		<th><%=stepOne%> : 사전평가, 실행평가, 사후평가 항목은 다음과 같습니다.</th>
                		<th>&nbsp;</th>
                	</tr> 
                </table>
<%
			}
			
			tDivCd = divCd[i];
			if ( !tDivCd.equalsIgnoreCase("") ) {
%>
				<br/><h3><%=stepOne%> : <%=stepTwo%> </h3>
                <table  class="table1">
                	<colgroup>
                		<col width="100px"/>
						<col width="550px"/>
						<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>설문번호</th>
						<th>설문내용</th>
						<th>&nbsp;</th>
                	</tr>   
<%
				String key = "";
				String value = "";
				Map<String, String> svQItemD = new HashMap<String, String>();
				
				svQItemD = (HashMap)svQItem.get(tDivCd);
				TreeMap tdm = new TreeMap(svQItemD);
				Iterator itD = tdm.keySet().iterator();
				
				int j = 0;
				while ( itD.hasNext() ) {
					j++;
					key = (String)itD.next();
					value = (String)tdm.get(key);
					key = String.valueOf(j);
%>
                	<tr>
                		<td>&nbsp;<%=key%></td>
                		<td style="text-align:left">&nbsp;<%=value%></td>
                		<td>&nbsp;</td>
                	</tr>	
<%
				}
%>
                </table>
<%
			}
		}
%>
                </div>
<script type="text/javascript">
//Syntax: var uniquevar=new animatedcollapse("DIV_id", animatetime_milisec, enablepersist(true/fase))
var collapseQ=new animatedcollapse("question", 800, true);
</script>
			</div>
			
 			<div class="contents1">
                <h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. '2012 안성세계 민속축전'의 분석결과 정리</h2><br/>
                <h3>
                	*방문객, 지역주민, 주최자, 전문가에 대한 인구통계 및 해당 설문에 대한 만족도 평가 분석결과입니다.&nbsp;&nbsp;
                	<a href="javascript:collapseR.slideit();">[분석결과 Show/Hide]</a>
                </h3>
                <div id="result" style="width:800px;">
<%
		int svUserInfoDSeq = 0;
		// 데이터를 맵으로 구성
		for ( int i=0; i<divList; i++ ) {
			switch ( i ) {
				case 0 : stepOne = "방문객"; stepTwo = "사전평가"; break;
				case 1 : stepOne = "방문객"; stepTwo = "실행평가"; break;
				case 2 : stepOne = "방문객"; stepTwo = "사후평가"; break;
				case 3 : stepOne = "지역주민"; stepTwo = "사전평가"; break;
				case 4 : stepOne = "지역주민"; stepTwo = "실행평가"; break;
				case 5 : stepOne = "지역주민"; stepTwo = "사후평가"; break;
				case 6 : stepOne = "주최자"; stepTwo = "사전평가"; break;
				case 7 : stepOne = "주최자"; stepTwo = "실행평가"; break;
				case 8 : stepOne = "주최자"; stepTwo = "사후평가"; break;
				case 9 : stepOne = "전문가"; stepTwo = "사전평가"; break;
				case 10 : stepOne = "전문가"; stepTwo = "실행평가"; break;
				case 11 : stepOne = "전문가"; stepTwo = "사후평가"; break;
			}
				
			tDivCd = divCd[i];
			if ( !tDivCd.equalsIgnoreCase("") ) {
				String chartsDivID = ""; // charts id
				int chartsDiv = 0;
%>
				<br/><br/>
                <table  class="table1">
                	<colgroup>
                		<col width="430px"/>
                		<col width="*"/>
                	</colgroup>
                	<tr>
                		<th><%=stepOne%> - <%=stepTwo%>에 대한 인구통계와 설문통계에 대한 분석결과입니다.</th>
                		<th>&nbsp;</th>
                	</tr> 
                </table>
<%
				String key = "";
				Map<String, String> svQItemD = new HashMap<String, String>();
				
				svQItemD = (HashMap)svQItem.get(tDivCd);
				TreeMap tdm = new TreeMap(svQItemD);
				Iterator itD = tdm.keySet().iterator();
				
				while ( itD.hasNext() ) {
					chartsDiv++;
					chartsDivID = tDivCd + chartsDiv;
					
					String question = "";
					Integer seq = 0;
					String userMailAddr = "";
					String regYmd = "";
					Integer age = 0;
					String area = "";
					String sex = "";
					Integer recNum = 0;
					Integer listNum = 0;
					
					Map<Integer, SVUser> svUserInfoD = new HashMap<Integer, SVUser>();
					SVUser svUser = new SVUser();
					Frequency fAge = new Frequency(); //*****
					Frequency fSex = new Frequency();
					Frequency fListNum = new Frequency();
					DescriptiveStatistics stats = new DescriptiveStatistics();
					
					key = (String)itD.next();
					
					query = "SELECT ROWNUM AS SEQ, A.USER_MAIL_ADDR AS USER_MAIL_ADDR " 
							  + "     , A.REG_YMD AS REG_YMD, A.AGE AS AGE, A.AREA AS AREA, A.SEX AS SEX "
							  + "     , B.REC_NUM AS REC_NUM, B.LIST_NUM AS LIST_NUM "
							  + "FROM ( "
							  + "  SELECT SV_ID, USER_MAIL_ADDR, REG_YMD/*참여일자*/, AGE/*나이*/, AREA/*지역*/, SEX/*성별*/ "
							  + "  FROM SV_USER_INFO "
							  + "  ORDER BY USER_MAIL_ADDR ASC "
							  + ") A,( "
							  + "  SELECT A.USER_MAIL_ADDR AS USER_MAIL_ADDR "
							  + "       , B.SV_ID AS SV_ID, B.REC_NUM AS REC_NUM "
							  + "       , A.LIST_NUM AS LIST_NUM, A.PKEY AS PKEY "
							  + "  FROM ( "
							  + "    SELECT USER_MAIL_ADDR, REC_NUM, LIST_NUM, PKEY "
							  + "    FROM SV_A_RESULT "
							  + "    ORDER BY PKEY ASC, REC_NUM ASC, LIST_NUM ASC "
							  + "  ) A, ( "
							  + "    SELECT SV_ID, REC_NUM "
							  + "    FROM SV_Q_ITEM "
							  + "    GROUP BY SV_ID, REC_NUM "
							  + "    ORDER BY SV_ID ASC, REC_NUM ASC "
							  + "  ) B "
							  + "  WHERE A.REC_NUM = B.REC_NUM "
							  + "    AND A.REC_NUM = ? "
							  + "  ORDER BY B.SV_ID ASC, B.REC_NUM ASC/*, A.PKEY ASC*/, A.USER_MAIL_ADDR ASC "
							  + ") B "
							  + "WHERE A.USER_MAIL_ADDR = B.USER_MAIL_ADDR "
							  + "  AND A.SV_ID = B.SV_ID "
							  + "  AND A.SV_ID = ? "
							  + "ORDER BY B.REC_NUM ASC/*, B.PKEY ASC*/, B.USER_MAIL_ADDR ASC, B.LIST_NUM ASC ";
					
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, key);
					pstmt.setString(2, tDivCd);
					
					ResultSet rset = pstmt.executeQuery();
					
//					out.println("REC_NUM:" + key + "<br/>");
					question = (String)tdm.get(key);
//					out.println("질문 " + question + "<br/>");
%>
				<br/><br/><h3><%=question%></h3>
<%
					while (rset.next()) {
						svUserInfoDSeq++;
						seq = rset.getInt("seq");
						userMailAddr = rset.getString("user_mail_addr");
						regYmd = rset.getString("reg_ymd");
						age = rset.getInt("age");
						area = rset.getString("area");
						sex = rset.getString("sex");
						recNum = rset.getInt("rec_num");
						listNum = rset.getInt("list_num"); // 답변
						
						svUser.setSeq(seq);
						svUser.setUserMailAddr(userMailAddr);
						svUser.setRegYmd(regYmd);
						svUser.setAge(age);
						svUser.setArea(area);
						svUser.setSex(sex);
						svUser.setRecNum(recNum);
						svUser.setListNum(listNum);
						
						svUserInfoD.put(svUserInfoDSeq, svUser);
						fAge.addValue(age); //*****
						fSex.addValue(sex);
						fListNum.addValue(listNum);
						stats.addValue(Double.parseDouble(listNum.toString()));
						//out.println("age:" + age + ", sex:" + sex + "<br/>");
					}
					rset.close();
					pstmt.close();
					
					svUserInfo.put(tDivCd, svUserInfoD);
					
%>
                <table  class="table1">
                	<colgroup>
                		<col width="350px"/>
                		<col width="350px"/>
                		<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>인구통계 - 성별통계</th>
                		<th>연령별통계</th>
                		<th>&nbsp;</th>
                	</tr> 
                	<tr>
<%
					double sexTotal = fSex.getCount("M") + fSex.getCount("F");
					double sexM = fSex.getCount("M") / sexTotal;
					double sexF = fSex.getCount("F") / sexTotal;
                			/* 남:fSex.getCount("M"), 여:fSex.getCount("F") */
%>
                		<td>
<!--  Highcharts -->
<script type="text/javascript">
$(function () {
    $('#containerSex_<%=chartsDivID%>').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '인구통계 - 성별통계'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['남', <%=sexM%>],
                ['여', <%=sexF%>]
            ]
        }]
    });
});
</script>
<!-- div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div -->
<div id="containerSex_<%=chartsDivID%>" style="min-width:350px;height:250px;border:1px solid #ccc;"></div>
                		</td>
                		<td>
<%
//					out.println("*****[" + key + "] 남:" + fSex.getCount("M") + ", 여:" + fSex.getCount("F") + "<br/>");
					Integer tmpAge = 0;
					String ageRange ="";
					
					double ageTotal = 0.0;
					double age20 = 0.0;
					double age30 = 0.0;
					double age40 = 0.0;
					
					for ( int j=20; j<50; j++ ) {
						tmpAge = tmpAge + Integer.parseInt(String.valueOf((fAge.getCount(j))));
//						out.println("*****[" + j + "] " + fAge.getCount(j));
						
						if ( j<30 ) {
							ageRange = "20대";
							if ( j==29 ) {
								age20 = Double.parseDouble(tmpAge.toString());;
//								out.println(ageRange + ":" + age20 + ", ");
								tmpAge = 0;
							}
						} else if ( j<40 ) {
							ageRange = "30대";
							if ( j==39 ) {
								age30 = Double.parseDouble(tmpAge.toString());;
//								out.println(ageRange + ":" + age30 + ", ");
								tmpAge = 0;
							}
						} else if ( j<50 ) {
							ageRange = "40대";
							if ( j==49 ) {
								age40 = Double.parseDouble(tmpAge.toString());
//								out.println(ageRange + ":" + age40);
								tmpAge = 0;
							}
/* 						} else if ( j<60 ) {
							ageRange = "50대";
							if ( j==59 ) {
								out.println("*****[" + key + "] " + ageRange + ":" + tmpAge + "<br/>");
								tmpAge = 0;
							}
						} else if ( j<70 ) {
							ageRange = "60대";
							if ( j==69 ) {
								out.println("*****[" + key + "] " + ageRange + ":" + tmpAge + "<br/>");
								tmpAge = 0;
							}
						} else if ( j<80 ) {
							ageRange = "70대";
							if ( j==79 ) {
								out.println("*****[" + key + "] " + ageRange + ":" + tmpAge + "<br/>");
								tmpAge = 0;
							} */
						}
					}
					
					ageTotal = age20 + age30 + age40;
					age20 = age20 / ageTotal;
					age30 = age30 / ageTotal;
					age40 = age40 / ageTotal;
%>
<!--  Highcharts -->
<script type="text/javascript">
$(function () {
    $('#containerAge_<%=chartsDivID%>').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '인구통계 - 연령별통계'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['20대', <%=age20%>],
                ['30대', <%=age30%>],
                ['40대', <%=age40%>]
            ]
        }]
    });
});
</script>
<div id="containerAge_<%=chartsDivID%>" style="min-width:350px;height:250px;border:1px solid #ccc;"></div>
                		</td>
                		<td>&nbsp;</td>
                	</tr>	
                </table>
                <table  class="table1">
                	<colgroup>
                		<col width="500px"/>
                		<col width="*"/>
                	</colgroup>
                	<tr>
                		<th>해당 설문에 대한 만족도 분석결과입니다.</th>
                		<th>&nbsp;</th>
                	</tr> 
                	<tr>
                		<td>
<%
//					out.println("*****[" + key + "] 매우양호:" + fListNum.getCount(1) + ", 양호:" + fListNum.getCount(2) + ", 보통:" + fListNum.getCount(3) + ", 불량:" + fListNum.getCount(4) + ", 매우불량:" + fListNum.getCount(5) + "<br/>");
                			/* 매우양호:fListNum.getCount(1)
                			, 양호:fListNum.getCount(2)
                			, 보통:fListNum.getCount(3)
							, 불량:fListNum.getCount(4)
							, 매우불량:fListNum.getCount(5) */
%>
<!--  Highcharts -->
<script type="text/javascript">
$(function () {
        $('#containerSatisfaction_<%=chartsDivID%>').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: [
                    '매우양호',
                    '양호',
                    '보통',
                    '불량',
                    '매우불량'
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: '만족도 (5점척도)'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} 명</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: '선택 수(명)',
                data: [<%=fListNum.getCount(1)%>,<%=fListNum.getCount(2)%>,<%=fListNum.getCount(3)%>,<%=fListNum.getCount(4)%>,<%=fListNum.getCount(5)%>]
            }]
        });
    });
</script>
<div id="containerSatisfaction_<%=chartsDivID%>" style="min-width:500px;height:250px;border:1px solid #ccc;"></div>
						</td>
                		<td>&nbsp;</td>
                	</tr> 
<%
					double mean = stats.getMean();
					double std = stats.getStandardDeviation();
					double median = stats.getPercentile(50);
					double conv100 = mean * ( 100 / 5);
					
//					out.println("*****[" + key + "]" + mean + ", " + std + ", " + median + "-->" + a + "<br/>");
                			/* 평균값:mean
                			, 표준편차:std
                			, 중앙값:median
							, 100분위 환산점수:conv100 */
%>
                	<tr>
                		<td>
<!--  Highcharts -->
<script type="text/javascript">
$(function () {
        $('#containerStats_<%=chartsDivID%>').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: ''
            },
            subtitle: {
                text: ''
            },
            xAxis: {
                categories: [
                    '평균값',
                    '표준편차',
                    '중앙값'
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: '통계값'
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} </b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: '기술적 통계 분석',
                data: [<%=mean%>,<%=std%>,<%=median%>]
            }]
        });
    });
</script>
<div id="containerStats_<%=chartsDivID%>" style="min-width:500px;height:250px;border:1px solid #ccc;"></div>
							<br/>
<%
					/* out.println("==" + stats.getGeometricMean() + ", " + stats.getKurtosis()
						+ "," + stats.getMax() + "," + stats.getMean() + "," + stats.getMin()
						+ "," + stats.getPercentile(5) + "," + stats.getPopulationVariance()
						+ "," + stats.getSkewness() + "," + stats.getStandardDeviation()
						+ "," + stats.getSum() + "," + stats.getSumsq()
						+ "," + stats.getVariance()	+ "," + stats.getWindowSize()); */
%>
						</td>
                		<td>&nbsp;</td>
                	</tr> 
                </table>
<%
				}
				out.println("<br/>");
			}
		}
%>
           	
<%
/* 		// 데이터를 맵으로 구성
		for ( int i=0; i<divList; i++ ) {
			tDivCd = divCd[i];
			if ( !tDivCd.equalsIgnoreCase("") ) {
				String key = "";
				Map<String, String> svQItemD = new HashMap<String, String>();
				
				svQItemD = (HashMap)svQItem.get(tDivCd);
				TreeMap tdm = new TreeMap(svQItemD);
				Iterator itD = tdm.keySet().iterator();
				
				out.println("Division : " + tDivCd + "<br/>"); //*****
				while ( itD.hasNext() ) {
					String subKey = "";
					Integer value = 0;
					String strValue = "";
					Map<String, Integer> svAResultD = new HashMap<String, Integer>();
					int j = 0;
					DescriptiveStatistics stats = new DescriptiveStatistics(); //-----
					
					key = (String)itD.next();
					
					query = "SELECT REC_NUM AS KEY, LIST_NUM AS VALUE "
						  + "FROM SV_A_RESULT "
						  + "WHERE REC_NUM = ? "
						  + "ORDER BY TO_NUMBER(REC_NUM) ASC, PKEY ASC ";
					
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, key);
					
					ResultSet rset = pstmt.executeQuery();
					
					
					while (rset.next()) {
						subKey = rset.getString("key");
						value = rset.getInt("value");
						
						j++;
						subKey = subKey + "|" + String.valueOf(j); // REC_NUM + seq로 구성하여 중복을 막고 차후 통계 데이터 로딩시 사용하기 위함
						svAResultD.put(subKey, value);
						stats.addValue(Double.parseDouble(value.toString())); //-----
					}
					rset.close();
					pstmt.close();
					
					svAResult.put(key, svAResultD);
//					out.println(tDivCd + "::" + svAResult.toString() + "<br/><br/>");
					
					strValue = (String)tdm.get(key);
					out.println("*****" + strValue + "<br/>");
					
					//*****
					double mean = stats.getMean();
					double std = stats.getStandardDeviation();
					double median = stats.getPercentile(50);
					double a = mean * ( 100 / 5);
					
					out.println("*****[" + key + "]" + mean + ", " + std + ", " + median + "-->" + a + "<br/>");
				}
				out.println("<br/><br/>");
			}
		} */
%>
            	</div>
<script type="text/javascript">
//Syntax: var uniquevar=new animatedcollapse("DIV_id", animatetime_milisec, enablepersist(true/fase))
var collapseR=new animatedcollapse("result", 800, true);
</script>
            </div>
        </div> 
    </div>
    <!--// id="bodywrap"-->
    
    <div id="footer"> <%@include file="../include/bottom.jsp" %> </div>
    <!--// id="footer"--> 
</div>
<!--// id="allwrap"-->

<!--  Highcharts -->
<script src="./Highcharts306/js/highcharts.js"></script>
<script src="./Highcharts306/js/modules/exporting.js"></script>

<!-- 로딩중 화면표시 스크립터 --> 
<script  type="text/javascript"> 
waiting.style.visibility="hidden" 
</script> 
<!-- 로딩중 화면표시 스크립터 끝 -->
</form>
</body>
<%
		conn.close();
%>
<%
	} else {
%>
<body>
	<div class="searchbar"><h1>잘못된 요청입니다. 파라미터 등을 확인해 주세요.</h1></div>
</body>
<%
	}
%>
</html>
