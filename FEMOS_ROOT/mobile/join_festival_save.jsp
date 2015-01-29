<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mobile.visiter.MobileVisiter" %>
<%@ page import="com.util.CharacterSet"%>
<%
    String festival_cd = request.getParameter("festival_cd");
	String visiter_nm = CharacterSet.UTF8toKorean(request.getParameter("visiter_nm"));
    String sex = request.getParameter("sex");
    String hp = request.getParameter("hp");
    String email = request.getParameter("email");
    
    MobileVisiter mv = new MobileVisiter();
    
    String mv_rtn = mv.strInsertVisiter(festival_cd, visiter_nm, sex, hp, email);
    
    if ( mv_rtn.length() > 0 ) {
//        response.sendRedirect("./join_festival_3.jsp");
//        String rtn[];
//        rtn = mv_rtn.split("|");
%>
<form name="form1" method="post" action="./join_festival_3.jsp">
    <input type="hidden" id="festival_cd" name="festival_cd" value="<%=festival_cd%>" />
    <input type="hidden" id="visiter_nm" name="visiter_nm" value="<%=visiter_nm%>" />
    <input type="hidden" id="sex" name="sex" value="<%=sex%>" />
    <input type="hidden" id="hp" name="hp" value="<%=hp%>" />
    <input type="hidden" id="email" name="email" value="<%=email%>" />
<!-- <input type="hidden" id="visiter_id" name="visiter_id" value="<%//=rtn[0]%>" />
    <input type="hidden" id="qrcode" name="qrcode" value="<%//=rtn[1]%>" />-->
	<input type="hidden" id="visiter_id" name="visiter_id" value="<%=mv_rtn%>" />
</form>
<script> 
    function actionDo(){ 
        document.form1.submit(); 
    }
    
    actionDo();
</script> 
<%
    } else {
%>
<script>alert('축제 등록에 실패하였습니다.');history.go(-1);</script>
<%
    }
%>
