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
<div id="testArea"></div>

<script>
    $("#num").change((e) => {
       // console.log("hiiii");
        console.log($(e.target).val());
        var cPage = $(e.target).val();
        $.ajax({
            url: `${pageContext.request.contextPath}/product/service/productReview?cPage=\${cPage}`,
            method: 'GET',
            data: {code:'test'},
            success(resp){
                console.log(resp);
                // $(resp.fr).each((i, {code, writer, category, title, content, regDate}) => {
                //     console.log(i + " - " + code, writer, category, title, content, regDate);
                // });
            },
            error: console.log
        });
        <%--$.ajax({--%>
        <%--    url: `${pageContext.request.contextPath}/service/select/frequentlyQuestion?cPage=\${cPage}`,--%>
        <%--    method: 'GET',--%>
        <%--    data: {},--%>
        <%--    success(resp){--%>
        <%--        console.log(resp.fr);--%>
        <%--        $(resp.fr).each((i, {code, writer, category, title, content, regDate}) => {--%>
        <%--            console.log(i + " - " + code, writer, category, title, content, regDate);--%>
        <%--        });--%>
        <%--    },--%>
        <%--    error: console.log--%>
        <%--});--%>
    });
    $(() => {
        $.ajax({
           url: '${pageContext.request.contextPath}/product/enroll/productReview',
           data: {type:'modify', no:1},
           success(resp){
               console.log(resp);
           },
            error:console.log
        });

       $.ajax({
          url: '${pageContext.request.contextPath}/product/service/productReview?cPage=0',
           data: {code:'test'},
          success(resp) {
              console.log(resp);
              $(resp.productReview).each((i, {no, writer, name, grade, announce, title, content, likes, pcode, regDate, readCount}) => {
                 console.log(writer, name, readCount);
                 var txt = `<div class='cook'><div class='no'>\${no}</div>
                            <div>\${writer}</div>
                            <div>\${likes}</div>
                            <div>\${announce}</div>
                            <div>\${regDate}</div>
                            <div>\${readCount}</div></div>
</br>
`;
                 $(testArea).append(txt);
              });
              $(".cook").click((e) => {
                  var code = $(e.target).parent().find('div.no').text();
                  $.ajax({
                     url: '${pageContext.request.contextPath}/product/cookie/productReview',
                      data: {code},
                      success(resp){
                         console.log(resp);
                      },
                      error: console.log
                  });
              });

          },
           error: console.log
       });
    });


</script>

</body>
</html>