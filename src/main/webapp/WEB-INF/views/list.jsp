<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<style type="text/css">
.container {
	margin-top:50px;
}
.row {
	margin:0px auto;
	width:900px;
}
h3 {
	text-align: center;
	color:red;
}
p {
	overflow:hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<h3>AWS CICD 1회차</h3>
			<c:forEach var="vo" items="${list }">
				<div class="col-md-3">
				  <div class="thumbnail">
				    <a href="/detail?fno=${vo.fno }">
				      <img src="${vo.poster }" style="width:100%">
				      <div class="caption">
				        <p>${vo.name}</p>
				        <p>${vo.address}</p>
				      </div>
				    </a>
				  </div>
				</div>
			</c:forEach>
		</div>
		<div class="row text-center" style="margin-top:20px;">
			<ul class="pagination">
				<c:if test="${startPage>1 }">
				<li><a href="/?page=${startPage-1 }">&lt;</a></li>
				</c:if>
				<c:forEach begin="${startPage}" end="${endPage}" var="i">
				<li class="${curPage==i?'active':'' }"><a href="/?page=${i}" >${i }</a></li>
				</c:forEach>
				<c:if test="${endPage<totalPage }">
				<li><a href="/?page=${endPage+1 }">&gt;</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</body>
</html>