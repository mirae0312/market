<%--
  Created by IntelliJ IDEA.
  User: wo
  Date: 2022-03-17
  Time: 오전 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>$Title$</title>
</head>
<body>
<sec:authentication property="principal" var="loginMember"/>
<a href="${pageContext.request.contextPath}/service/view/echoProposal">echo</a>
<a href="${pageContext.request.contextPath}/service/enroll/announcement">공지등록</a>
<h1>${loginMember.id}</h1>
<h1>${loginMember.grade}</h1>
</body>
</html>