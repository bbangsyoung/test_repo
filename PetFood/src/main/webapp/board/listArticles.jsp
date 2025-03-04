<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="articlesList" value="${articlesMap.articlesList}" />
<c:set var="totArticles" value="${articlesMap.totArticles}" />
<c:set var="section" value="${articlesMap.section}" />
<c:set var="pageNum" value="${articlesMap.pageNum}" />
<%
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<style>
html, body, div, span, h1, h2, h3, p, a, input, select, option, table,
	tr, th, td, search, input {
	margin: 0;
	padding: 0;
	border: 0;
	box-sizing: border-box;
	color: #333;
	texdt-decoration: none;
}

.wrap {
	max-width: 1000px;
	margin: 0 auto;
	padding: 50px;
}

.tit {
	text-align: center;
	font-size: 30px;
	font-weight: bold;
	background-color: #fffde7;
	padding: 50px 0;
}

.sub_tit {
	text-align: center;
	margin-bottom: 30px;
	margin-top: 20px;
}

.sub_tit a {
	color: #fff;
	background-color: #5e92c6;
	padding: 5px 20px;
	display: inline-block;
	text-decoration: none;
	border-radius: 20px;
}

.sub_tit a:hover {
	text-decoration: underline;
	background-color: #5282b2;
}

.sub_tit strong {
	font-weight: bold;
	color: #6ba1d8;
}

.board_table {
	width: 100%;
	border-collapse: collapse;
	text-align: center;
}

.b_list th, .b_list td {
	height: 50px;
	line-height: 50px;
}

.b_list tr {
	border-bottom: 1px solid #eaeaea;
	background-color: #fafafa;
}

.board_table .b_tit {
	background-color: #fff;
	border-top: 3px solid #ffd66a;
	border-bottom: 1px solid #ccc;
}

.b_search {
	margin: 20px auto;
	width: 400px;
	height: 40px;
	border: none;
}

.b_search * {
	height: 40px;
	border-radius: 10px;
}

.b_search select {
	width: 90px;
	transform: translateY(-2px);
	border: 1px solid #ccc;
}

.b_search input:nth-of-type(1) {
	background-color: #fafafa;
	border: 1px solid #ccc;
}

.b_search input:nth-of-type(2) {
	width: 80px;
	cursor: pointer;
	background-color: #454040;
	color: #fff;
}

.b_search input:nth-of-type(2):hover {
	background-color: #6c5e5e;
}

.newWrite a {
	display: block;
	width: 100%;
	height: 40px;
	line-height: 40px;
	text-align: center;
	background-color: #fffde7;
	color: #111;
	margin-top: 20px;
	text-decoration: none;
}

.newWrite a:hover {
	background-color: #ffd66a;
}
</style>
<meta charset="UTF-8">
<title>커뮤니티</title>
</head>
<jsp:include page="../view/header.jsp"></jsp:include>
<body>
	<div class="wrap">
		<h1 class="tit">글 목록</h1>
		<c:if test="${user.userName != null}">
			<h3 class="sub_tit">
				<strong>${user.userName}님 환영합니다</strong>
			</h3>
		</c:if>
		<!-- <form action="PetFoodBoard/SearchBoardList.do" method="post"> -->
		<form action="${contextPath}/PetFoodBoard/SearchBoardList.do"
			method="post">
			<table class="board_table b_search">
				<tr>
					<td><select name="searchCondition">
							<option value="BOTH">제목+내용</option>
							<option value="TITLE">제목</option>
							<option value="CONTENT">내용</option>
					</select> <input type="text" name="searchKeyword" /> <input type="submit"
						value="검색"></td>
				</tr>
			</table>
		</form>
		<!-- <table align="center" border="1"  width="80%"  > -->
		<table class="board_table b_list">
			<tr class="b_tit">
				<td>글번호</td>
				<td>작성자</td>
				<td>제목</td>
				<td>작성일</td>
			</tr>
			<c:choose>
				<c:when test="${articlesList ==null }">
					<tr height="10">
						<td colspan="4">
							<p align="center">
								<b><span style="font-size: 9pt;">등록된 글이 없습니다.</span></b>
							</p>
						</td>
					</tr>
				</c:when>
				<c:when test="${articlesList !=null }">
					<c:forEach var="article" items="${articlesList }"
						varStatus="articleNum">
						<tr align="center">
							<td width="5%">${articleNum.count}</td>
							<td width="10%">${article.id }</td>
							<td align='left' width="35%"><span
								style="padding-right: 30px"></span> <a class='cls1'
								href="${contextPath}/PetFoodBoard/viewArticle.do?articleNO=${article.articleNO}"
								display=block>${article.title}</a></td>
							<td width="10%"><fmt:formatDate value="${article.writeDate}" /></td>
						</tr>
					</c:forEach>
				</c:when>
			</c:choose>
		</table>
		<p class="newWrite">
			<c:if test="${user.userName != null}">
				<a href="${contextPath}/PetFoodBoard/articleForm.do">글쓰기</a>
			</c:if>
		</p>
	</div>

	<!-- 하단 글 갯수 리스트 -->
	<div class="bottomPaging">
		<div class="pagingMenu">
			<c:if test="${totArticles != null }">
				<c:choose>

					<c:when test="${totArticles >100 }">
						<!-- 글 개수가 100 초과인경우 -->
						<c:forEach var="page" begin="1" end="10" step="1">
							<c:if test="${section >1 && page==1 }">
								<a class="no-uline"
									href="${contextPath }/PetFoodBoard/listArticles.do?section=${section-1}&pageNum=${(section-1)*10 +1 }">&nbsp;
									pre </a>
							</c:if>
							<a class="no-uline"
								href="${contextPath }/PetFoodBoard/listArticles.do?section=${section}&pageNum=${page}">${(section-1)*10 +page }
							</a>
							<c:if test="${page ==10 }">
								<a class="no-uline"
									href="${contextPath }/PetFoodBoard/listArticles.do?section=${section+1}&pageNum=${section*10+1}">&nbsp;
									next</a>
							</c:if>
						</c:forEach>
					</c:when>


					<c:when test="${totArticles ==100 }">
						<!--등록된 글 개수가 100개인경우  -->
						<c:forEach var="page" begin="1" end="10" step="1">
							<a class="no-uline" href="#">${page } </a>
						</c:forEach>
					</c:when>
					<c:when test="${totArticles< 100 }">


						<!--등록된 글 개수가 100개 미만인 경우  -->
						<c:forEach var="page" begin="1" end="${totArticles/13 +1}"
							step="1">
							<c:choose>
								<c:when test="${page==pageNum }">
									<a class="sel-page"
										href="${contextPath }/PetFoodBoard/listArticles.do?section=${section}&pageNum=${page}">${page }
									</a>
								</c:when>
								<c:otherwise>
									<a class="no-uline"
										href="${contextPath }/PetFoodBoard/listArticles.do?section=${section}&pageNum=${page}">${page }
									</a>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:when>
				</c:choose>
			</c:if>
		</div>
	</div>

	<jsp:include page="../view/footer.jsp"></jsp:include>
</html>