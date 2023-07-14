<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시판 웹사이트</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css">
</head>
<body>
<% int bbsID = 0;
	if(request.getParameter("bbsID")!=null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID==0){ // 위 이프문을 통한 값이 안들어옴
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 게시물입니다.')");
		script.println("history.back();");
		script.println("</script>");
	}
	
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	
%>
<%@ include file="nav.jsp" %>
<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd; ">
			<thead>
				<tr>
					<th colspan="3" style="background-color: #eeeeee; text-align:center; margin-top:100px;">게시판 글보기 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:20%;">글 제목</td>
					<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
				</tr>
				<tr>
					<td style="width:20%;">작성자</td>
					<td colspan="2"><%=bbs.getUserID() %></td>
				</tr>
				<tr>
					<td style="width:20%;">작성일자</td>
					<td colspan="2"><%=bbs.getBbsDate().substring(0,11)+bbs.getBbsDate().substring(11,13)+"시"+bbs.getBbsDate().substring(14,16)+"분" %></td>
				</tr>
				<tr>
					<td style="width:20%;">글 내용</td>
					<td colspan="2" style="min-height:200px; text-align:left;">
						<%=bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %>
					</td>
				</tr>
			</tbody>
		</table>
		<a href="bbs.jsp" class="btn btn-primary">목록보기</a>
		<% if(session.getAttribute("userID")!=null&&session.getAttribute("userID").equals(bbs.getUserID())){ %> 
			<a href="update.jsp?bbsID=<%=bbs.getBbsID()%>" class="btn btn-primary">수정하기</a>
			<a href="deleteAction.jsp?bbsID=<%=bbs.getBbsID()%>" class="btn btn-primary" onclick="return confirm('정말 삭제하시겠습니까?')">삭제하기</a>
		<% } %>
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