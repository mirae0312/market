<%--
  Created by IntelliJ IDEA.
  User: wo
  Date: 2022-03-13
  Time: 오후 8:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
<script
    src="https://code.jquery.com/jquery-3.6.0.min.js"
    integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
    crossorigin="anonymous"></script>
</head>

<body>
<a href="${pageContext.request.contextPath}/login/snsLogin/kakao">카카오</a><br>
<a href="${pageContext.request.contextPath}/login/snsLogin/naver">네이버</a><br>
<a href="${pageContext.request.contextPath}/login/snsLogin/google">구글</a><br>
<button id="checks">check</button>
<script>
    $(checks).click(() => {
        $.ajax({
            url: '${pageContext.request.contextPath}/login/certifiedNum',
            data: {checkType:'IP', name:'홍길동', email:'honggd@gmail.com'},
            success(resp){
                console.log(resp);
            },
            error: console.log
        });
    });

</script>
</body>
</html>