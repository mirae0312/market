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
    <meta charset="UTF-8">
    <title>question</title>
    
 <style>
 		.csPage{
            padding-top: 65px;
            margin: 0 auto;
            display: flex;
        }
        /* leftside-title */
        .cs-title{
        	font-weight: 500;
        }
        #cs-mainTitle {padding-bottom: 30px}
        
        .leftSide{
            /* float: left; */
        }
        .leftSide a{
            /* display: block; */
            overflow: hidden;
            padding: 14px 0 16px 20px;
            /* background: #fff; */
            background-size: 6px 11px;
            font-size: 14px;
            color: #666;
            line-height: 20px;
            letter-spacing: -.3px;
            width: 170px;
        }

        .leftSide-csTitle{
            font-size: 20px;
            font-weight: 500; */
    		margin-bottom: 30px;
        }
        .leftSide-listDiv{
            border: 1px solid #f2f2f2;
        }
        .leftSide-list{
            list-style-type: none;
            padding-left: 0px;
            margin: 0;
        }
        .leftSide-list li{
            border-bottom: 1px solid #f2f2f2;
            display: flex;
            align-items: baseline;
        }
        .fa-chevron-right{
        	color: #666;
        }

        #leftSide-inquire {
            display: block;
            overflow: hidden;
            width: 200px;
            height: 60px;
            margin-top: 20px;
            padding: 9px 0 0 22px;
            border-radius: 0 100px 100px 0;
            background: #fafafa;
            background-size: 6px 11px;
            font-size: 12px;
            color: #333;
            line-height: 20px;
        }

        #leftSide-inquire span{
            display: block;
            padding-bottom: 1px;
            font-weight: 700;
            font-size: 14px;
        }
        /* leftside on */
 		.leftSide-list #userClick, .leftSide-list #userClick a, .leftSide-list #userClick i, .leftSide-list li:hover, .leftSide-list li a:hover, .leftSide-list li:hover > .fa-chevron-right{
            background: #fafafa;
            font-weight: 700;
            color: #5f0080;
        }
        .leftsideQuestion-div{
        	position:relative;
        }
        .leftsideQuestion-div i{
        	text-align: center; */
			position: absolute;
    		right: 18px;
    		bottom: 23px;
    		color:var(--purple);
        }

        /* csBoard */
        .csPage-section{
            /* float: right; */
            padding-left: 30px;
           
        }
        .csPage-aticle{
            padding: 5px 0 34px;
        }
        .csPage-aticle h2{
            height: 36px;
            /* font-weight: 700; */
            font-size: 24px;
            line-height: 36px;
            color: #333;
            letter-spacing: -.5px;
        }
        .csPage-aticle span {
            padding-left: 11px;
            font-size: 14px;
            color: #999;
            line-height: 20px;
            letter-spacing: -.3px;
            vertical-align: 3px;
        }
        /* csBoard */
        .csBoard{
        	
        }
        .csTable{
            border-top: 2px solid var(--purple);
            width: 880px;
            border-collapse: collapse;
            font-size: 12px;
            
        }
        
        .csTable tr td{
        	padding: 12px;
    		border-bottom: 1px solid #f4f4f4;
    		text-align: center;
    		vertical-align: middle;
    		word-wrap: break-word;
        }
        /* .csTable thead tr {
        	border-bottom: 1px solid black;
        } */
        
        .csTable thead th {
        	padding: 20px 0;
    		vertical-align: middle;
    		font-size: 12px;
    		font-weight: 500;
        }
        
        .csTable tr td{
        	padding: 12px;
    		border-top: 1px solid #f4f4f4;
    		text-align: center;
    		vertical-align: middle;
    		word-wrap: break-word;
        }
        .csTable tbody tr:first-child td{
        	border-top: 1px solid #333;
        }

        /* write-section */
        .write-section{
            height: 80px;
            padding: 0;
            border-top: 1px solid #e6e6e6;
            margin-top: 30px;
            
        }
		.write-section .writeBox{
			float: right;
    		padding-top: 60px;
		}
        
        .write-section button {
            width: 100px;
    		display: inline-block;
    		line-height: 30px;
    		text-align: center;
    		background-color: #795b8f;
    		border: 1px solid #5f0080;
    		color: #fff;
    		font-size: 15px;
    		float: right;
    		margin-left: 2px;
    		font-size: 13px;
        }
        .write-section button:hover{
        	background-color: var(--white);
        	color: var(--purple);
        	border: 1px solid var(--purple);
        }
        
        /* title */
        .csPage-section .list-title{
        	padding-bottom: 33px;
    		padding-left: 20px;
    		font-size: small;
    	}
        .csPage-section .list-title p{
        	overflow: hidden;
    		font-size: 14px;
    		color: #333;
    		line-height: 22px;
    		letter-spacing: -.3px;
        }
        
        
        /* pagenation */
        .pagenation{
            text-align: center;
            margin: 60px 0 0;
        }
        .pagenation ul{
        	list-style-type: none;
        }
        .pagenation li{
        	display: inline-block;
			/*width: 34px; */
    		height: 34px;
    		border: 1px solid #ddd;
    		/* border-left: 0; */
    		vertical-align: top;
        }
        
 </style>
 
    <!-- cs page --> 
<div class="csPage">
    <!--  왼쪽 사이드바 -->
    <div class="leftSide">
        <div class="leftSide-csTitle"><h2 class="cs-title" id="cs-mainTitle">고객센터</h2></div>
        <div class="leftSide-listDiv">
            <ul class="leftSide-list">
                <li >
                    <a href="${pageContext.request.contextPath}/service/view/announcement" id="" onclick="" >공지사항</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="" >
                    <a href="${pageContext.request.contextPath}/service/view/productReview" onclick="" >자주하는 질문</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="" >
                    <a href="${pageContext.request.contextPath}/service/view/question" onclick="" >1:1 문의</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/service/view/largeProposal" onclick="" >대량주문 문의</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/service/view/productProposal" onclick="" >상품 제안</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="" id="userClick">
                    <a href="${pageContext.request.contextPath}/service/view/echoProposal" onclick="" >에코포장 피드백</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
            </ul>
        </div>
        
        <!-- leftSide chatbot? 1:1 문의하기 -->
        <div class="leftsideQuestion-div">
            <a href="${pageContext.request.contextPath}/service/enroll/question" id="leftSide-inquire">
            <span class="">도움이 필요하신가요?</span>1:1 문의하기</a>
            <!-- <i class="fas fa-chevron-right"></i> -->
        </div>
    </div>
    
    <!-- 에코포장 피드백 시작 -->  
    <div class="csPage-section">
        <div class="csPage-aticle">
            <h2 class="cs-title">에코포장피드백</h2>
        </div>
        <ul class="list-title">
        	<li><p>에코 박스에 대한 피드백이나 새로운 포장재에 대한 제안을 남겨주세요.</p></li>
        	<li><p>더욱 세심하게 포장되었으면 하는 상품이 있다면 언제든 말씀주세요.</p></li>
        	<li><p>제안해 주신 의견은 담당자가 실시간으로 모니터링할 예정이나 별도 답변 안내는 되지 않음을 양해 부탁드립니다.</p></li>
        	<li><p>배손관련, 주문(취소/교환/환불)관련 문의 및 요청 사항은 1:1문의/카카오톡/고객센터(1644-1107)로 문의 바랍니다.</p></li>
        </ul>
        <!-- 게시판 -->
        <div class="csBoard">
            <table class="csTable">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="board" items="announceList">
                    <tr>
                        <td>1</td>
                        <td><a href="${pageContext.request.contextPath}/service/announcementDetail">테스트</a></td>
                        <td>마켓갈래</td>
                        <td>2022</td>
                        <td>2</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="pagenation">
            	${pagebar}
            </div>

            <!-- 글쓰기 -->
            <div class="write-section">
                    <div class="writeBox">
                        <button type="submit">글쓰기</button>
                    </div>
            </div>
            
            
        </div>
    </div>
       
       
       
    <!-- cs page 끝 -->
    </div>

  
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>