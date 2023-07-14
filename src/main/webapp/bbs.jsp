<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList,java.io.PrintWriter,bbs.*" %>
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
<%  userID = null;
	if(session.getAttribute("userID")!=null){
		userID=(String) session.getAttribute("userID");
	}
	int pageNumber=1;
	if(request.getParameter("pageNumber")!=null){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	
	BbsDAO bbsDAO = new BbsDAO();
	ArrayList<Bbs> list = bbsDAO.getList(pageNumber);

%>
<div class="container">
	<div class="row">
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd; margin-top:100px;">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align:center;">번호</th>
					<th style="background-color: #eeeeee; text-align:center;">제목</th>
					<th style="background-color: #eeeeee; text-align:center;">작성자</th>
					<th style="background-color: #eeeeee; text-align:center;">작성일</th>
				</tr>
			</thead>
			<tbody>
			<%

				for(int i = 0; i<list.size();i++){ %>
					
				<tr>
					<td><%=list.get(i).getBbsID() %></td>
					<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle()%></a></td>
					<td><%=list.get(i).getUserID() %></td>
					<td><%=list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
				</tr>
			<%} %>
			</tbody>
		</table>
	<%
			if (pageNumber != 1 ) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
				class="btn btn-success btn-arrow-left">이전</a>
			<%
			}
			if (bbsDAO.nextPage(pageNumber + 1)) {
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber + 1%>"
				class="btn btn-success btn-arrow-right">다음</a>
			<%
			}
			%>
		<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
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