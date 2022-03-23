<%--
  Created by IntelliJ IDEA.
  User: wo
  Date: 2022-03-23
  Time: 오후 5:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>$Title$</title>
</head>
<body>

    <form:form action="${pageContext.request.contextPath}/service/enroll/announcement" method="post">
        <input type="text" name="title" value="hi">
        <input type="text" name="writer" value="honggd">
        <input type="text" name="content" value="test">
        <input type="file" name="upFile">
        <input type="file" name="upFile">
        <input type="submit" value="submit">
    </form:form>
</body>
</html>