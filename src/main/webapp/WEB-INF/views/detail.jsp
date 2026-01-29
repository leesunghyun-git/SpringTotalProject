<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
}
</style>
</head>
<body>
	<div class="container">
		<div class="col-sm-9">
			<h3>상세 보기</h3>
			<table class="table">
				<tr>
					<td width="30%" class="text-center" rowspan="8">
						<img src="${vo.poster}" style="width:220px;height:300px">
					</td>
					<td colspan="2">
						<h3>${vo.name}&nbsp;<span style="color:orange">${vo.score}</span></h3>
					</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">주소</td>
					<td width="55%">${vo.address}</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">전화</td>
					<td width="55%">${vo.phone}</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">음식 종류</td>
					<td width="55%">${vo.type}</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">가격대</td>
					<td width="55%">${vo.price}</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">영업시간</td>
					<td width="55%">${vo.time}</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">주차</td>
					<td width="55%">${vo.parking}</td>
				</tr>
				<tr>
					<td class="text-center" style="color:gray" width="15%">테마</td>
					<td width="55%">${vo.theme}</td>
				</tr>
			</table>
			<table class="table">
				<tr>
					<td>${vo.content}
					</td>
				</tr>
				<tr>
					<td class="text-right"><a href="/find" class="btn btn-sm btn-info">맛집 검색</a></td>
					<td class="text-right"><a href="/" class="btn btn-sm btn-primary">목록</a></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>