<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter,bbs.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 웹사이트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
</head>
<body>
<%@ include file="nav.jsp" %>
<% 
//등록된 세션이 없다면 로그인하라는 메세지를 띄운다
if(userID == null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 해주세요.')");
	script.println("location.href='login.jsp'");
	script.println("</script>");
}
//게시물아이디값을 받지 못했다면 유효하지않은 글이라고 표시한다
int bbsID = 0;
if(request.getParameter("bbsID")!=null){
bbsID = Integer.parseInt(request.getParameter("bbsID"));
}
if(bbsID==0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('유효하지 않은 글입니다.')");
	script.println("location.href='bbs.jsp'");
	script.println("</script>");
}
//세션에 등록된 아이디와 게시물 번호 기준으로 받아온 아이디가 일치하지 않으면 권한이 없다고 표시한다. 
Bbs bbs = new BbsDAO().getBbs(bbsID);
if(!userID.equals(bbs.getUserID())){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다.')");
	script.println("location.href='bbs.jsp'");
	script.println("</script>");
}
%>
<div class="container">
	<div class="row">
		<form action="updateAction.jsp?bbsID=<%=bbsID %>" method="post">
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd; ">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #eeeeee; text-align:center margin-top:100px;;">게시판 수정 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="bbsTitle" class="form-control" placeholder="글 제목" maxlength="50" value="<%=bbs.getBbsTitle()%>" /></td>
				</tr>
				<tr>
					<td><textarea name="bbsContent" class="form-control" placeholder="" maxlength="2048" style="height:350px;"><%=bbs.getBbsContent()%></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="btn btn-primary pull-right" value="수정하기" />
		</form>
	</div>
</div>

	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<script src = "js/bootstrap.js"></script>
<script type="text/javascript">
	$( document ).ready(function() {
		$(".mainNbbs").children(":eq(1)").addClass("active");
	})
</script>
</body>
</html>