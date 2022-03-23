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

        /* csBoard-search */
        .csSearch-section{
            height: 80px;
            padding: 0;
            border-top: 1px solid #5e3d5a;
            margin-top: 30px;
        }

        .csSearch-section form{
            float:right;
            padding-top: 30px;
            font-size:14px;
        }
        .csSearch-section form span{
            padding-right: 30px;
            margin:auto 0;
        }

		
        
        .csSearch-section input[type=text]{
            height: 34px;
            line-height: 34px;
            width: 220px;
            border: 1px solid #bfbfbf;
            color: #000;
            /* float: right; */
            padding: 4px;
        }
        .csSearch-section button {
            background-color: #7a5c90;
    		color: white;
    		padding: 9px;
    		border: none;
        }
        
        /* title */
        .cs-title{
        	font-weight: 500;
        }
        #cs-mainTitle{
        	padding-bottom: 30px;
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
      	/* categorydata */
      	.category-data{
      		position: relative;
    		z-index: 1;
      	}
      	.category-btn{
      		overflow: hidden;
    		position: absolute;
    		right: 0;
		    top: -74px;
		    width: 157px;
    		height: 44px;
    		padding: 11px 0 0 15px;
    		border: 1px solid #ddd;
    		font-size: 14px;
    		color: #666;
    		line-height: 18px;
    		letter-spacing: -.5px;
      	}
      	.category-data .categories{
      		list-style-type: none;
      		display: none;
    		position: absolute;
    		right: 0;
    		top: -30px;
    		width: 157px;
    		border: 1px solid #dddfe1;
    		border-top: 0;
      	}
      	.category-data .categories:active{
      		display:block;
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
                <li class="" id="userClick">
                    <a href="${pageContext.request.contextPath}/service/view/productReview" onclick="" >자주하는 질문</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
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
                <li class="">
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
    
    <!-- 자주하는 질문 시작 -->  
    <div class="csPage-section">
        <div class="csPage-aticle">
            <h2 class="cs-title">자주하는 질문<span class="cs-title">고객님들께서 가장자주하는질문들을 모두 모았습니다.</span></h2>
        </div>
        <div class="category-data">
        	<a href="" class="category-btn">선택 <i class="fas fa-caret-down"></i></a>
        	<ul class="categories">
        		<li class="search-category"><a href="">배송/포장</a></li>
        		<li><a href="">상품</a></li>
        		<li><a href="">선물하기</a></li>
        		<li><a href="">주문/결제/대량주문</a></li>
        		<li><a href="">취소/교환/환불</a></li>
        		<li><a href="">이벤트/쿠폰/적립금</a></li>
        		<li><a href="">회원</a></li>
        		<li><a href="">서비스 이용</a></li>
        	</ul>
        </div>
        <!-- 게시판 -->
        <div class="csBoard">
            <table class="csTable">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>카테고리</th>
                        <th>제목</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="board" items="announceList">
                    <tr>
                        <td>1</td>
                        <td><a href="${pageContext.request.contextPath}/service/announcementDetail">테스트</a></td>
                        <td>마켓갈래</td>
                    </tr>
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="pagenation">
            	${pagebar}
            </div>

            <!-- 검색 테이블 -->
            <div class="csSearch-section">
                <form action="">
                                    
                    <div class="search-section">
                        <input type="text" name="keyword"/><button type="submit">
                        <i class="fas fa-search"></i></button>
                    </div>
                </form>
                
            </div>
            
            
        </div>
    </div>
       
       
       
    <!-- cs page 끝 -->
    </div>

  
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>