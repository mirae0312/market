<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
    <form method="post">
        <input type="text" name="username">
        <input type="password" name="password">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <button type="submit">로그인</button>
    </form>
<%--    <a href="https://kauth.kakao.com/oauth/authorize?client_id=2ae5bd0deaf271ba341cbf761624570d&redirect_uri=http://localhost:10000/market/login/kakaoLogin&response_type=code">--%>
    <a href="${pageContext.request.contextPath}/login/snsLogin/kakao">
        카카오 로그인
    </a>
    <a href="${pageContext.request.contextPath}/login/snsLogin/google">
        google 로그인
    </a>
</body>
</html>