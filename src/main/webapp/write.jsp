<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
<div class="container">
	<div class="row">
		<form action="writeAction.jsp" method="post">
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd; ">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #eeeeee; text-align:center;">게시판 글쓰기 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" name="bbsTitle" class="form-control" placeholder="글 제목" maxlength="50"/></td>
				</tr>
				<tr>
					<td><textarea name="bbsContent" class="form-control" placeholder="" maxlength="2048" style="height:350px;"/></textarea></td>
				</tr>
			</tbody>
		</table>
		<input type="submit" class="btn btn-primary pull-right" value="글쓰기" />
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