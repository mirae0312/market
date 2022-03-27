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
    <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
            crossorigin="anonymous"></script>
</head>
<body>
<%--<sec:authentication property="principal" var="loginMember"/>--%>
<a href="${pageContext.request.contextPath}/service/view/echoProposal">echo</a>
<a href="${pageContext.request.contextPath}/service/enroll/announcement">공지등록</a>
<h1>${loginMember.id}</h1>
<h1>${loginMember.grade}</h1>
<input type="number" name="num" id="num">

<script>
    $("#num").change((e) => {
       // console.log("hiiii");
        console.log($(e.target).val());
        var cPage = $(e.target).val();
        $.ajax({
            url: `${pageContext.request.contextPath}/service/select/frequentlyQuestion?cPage=\${cPage}`,
            method: 'GET',
            data: {},
            success(resp){
                console.log(resp.fr);
                $(resp.fr).each((i, {code, writer, category, title, content, regDate}) => {
                    console.log(i + " - " + code, writer, category, title, content, regDate);
                });
            },
            error: console.log
        });

    });

</script>

</body>
</html>