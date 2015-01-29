<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>불편사항 입력_테스트</title>
</head>
<body>
<form id="form1" name="form1" action="./upload_file_prc.jsp" method="post" enctype="multipart/form-data">
	<table border="1" width="600px">
		<tr>
			<th>Visiter ID</th>
			<td>
				<input type="hidden" id="festival_cd" name="festival_cd" value="FES10001" />
				<input type="text" id="visiter_id" name="visiter_id" value="FES100012012100200001" />
			</td>
		</tr>
		<tr>
			<th>불편사항구분</th>
			<td>
				<select id="ivt_div" name="ivt_div">
				<%=com.util.CodeUtil.getCodeListCombo("A70","") %>
				</select>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea id="ivt_content" name="ivt_content" rows="5" style="width:100%;"></textarea>
			</td>
		</tr>
		<tr>
			<th>첨부사진</th>
			<td>
				<input type="file" id="attach_file" name="attach_file"  />
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;"><input type="submit" value="전송" /></td>
		</tr>
	</table>
</form>
</body>
</html>