<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="마켓" name="title"/>
</jsp:include>
	<h1>우왕 인덱스다~</h1>
	<form method="post" action="${pageContext.request.contextPath}/logout">
		<button type="submit">로그아웃</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
	
	<br />
	<br />
	<input type="button" value="한태우" onclick="location.href='${pageContext.request.contextPath}/purchase/tarr4hMain'"/>
</body>
</html>