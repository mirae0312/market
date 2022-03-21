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
    <title>Announcement</title>
    
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
            display: block;
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
        

        /* csBoard-search */
        .csSearch-section{
            height: 80px;
            padding: 0;
            border-top: 1px solid var(--purple);
        }

        .csSearch-section form{
            display: flex;
            padding-top: 30px;
            font-size:14px;
        }
        .csSearch-section form span{
            padding-right: 30px;
            margin:auto 0;
        }

		.search-checkbox{
			padding-right: 60px;
			margin:auto;
		}
		
		.search-checkbox label{
			padding-right: 10px;
		}
		.search-checkbox label input[type=checkbox]{
			margin-right: 5px;
		}
		
        .pagenation{
            text-align: center;
        }
        .pagenation ul{
        	list-style-type: none;
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
            color: var(--purple);
            background-color: var(--purple);
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
        /* leftside on */
 		.leftSide-list #userClick, .leftSide-list #userClick a, .leftSide-list #userClick i, .leftSide-list li:hover, .leftSide-list li a:hover, .leftSide-list li:hover > .fa-chevron-right{
            background: #fafafa;
            font-weight: 700;
            color: #5f0080;
        }
        
        /* inquire page */
        .page-section{
			padding-left: 30px;
        }

        /* inquire-title */
        .insert-title{
            height: 36px;
            font-weight: 500;
            font-size: 24px;
            line-height: 36px;
            color: #333;
            letter-spacing: -.5px;
        }

        /* board-table */
        .board-write{
            font-size: 12px;
        }
        .board-write table input[type=text], .board-write table select{
            height: 30px;
            line-height: 25px;
            border: 1px solid #d9d9d9;
            color: #202020;
        }
        .board-write table th{
            width: 110px;
            padding: 15px 0 15px 20px;
            background-color: #f7f5f8;
            border-bottom: 1px solid #f4f4f4;
            text-align: left;
            font-weight: 400;
            vertical-align: middle;
        }
        .board-write table td{
            width: auto;
            padding: 15px 0 15px 10px;
            height: 23px;
            border-top: 1px solid #f4f4f4;
            border-bottom: 1px solid #f4f4f4;
            vertical-align: middle;
            line-height: 20px;
        }
        .board-write table i{
            color: white;
            background-color: black;
            border-radius: 5px;
            padding: 0 3px;
        }
        .board-write dt::before{
            content: "-";
        }
        .board-write dd::before{
            content: "-";
            
        }
        .board-write dd{
            text-indent: 10px;
        }
        #write-textarea{
            width: 100%;
            height: 474px;
            user-select: auto;
            resize: none;
        }
        .upload-table span{
            color: white;
            background-color: black;
            border-radius: 5px;
            padding: 0 3px;
            border-left: 1px dashed;
        }
        .board-submitBtn{
            width: 150px;
            display: inline-block;
            line-height: 40px;
            text-align: center;
            background-color: #795b8f;
            border: 1px solid #5f0080;
            color: #fff;
            font-size: 15px;
            float: right;
            margin-left: 2px;
            font-size: 13px;
        }
        .board-submitBtn:hover{
        	background-color: #5f0080;
        }
 </style>
 
    <!-- cs page --> 
<div class="csPage">
    <!-- 고객센터 왼쪽 사이드바 -->
    <div class="leftSide">
        <div class="leftSide-csTitle"><h2 class="cs-title" id="cs-mainTitle">고객센터</h2></div>
        <div class="leftSide-listDiv">
            <ul class="leftSide-list">
                <li id="userClick">
                    <a href="${pageContext.request.contextPath}/service/announcement" id="" onclick="" >공지사항</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/cs/notice" onclick="" >자주하는 질문</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/service/myQuestion" onclick="" >1:1 문의</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/cs/notice" onclick="" >대량주문 문의</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/cs/notice" onclick="" >상품 제안</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
                <li class="">
                    <a href="${pageContext.request.contextPath}/cs/notice" onclick="" >에코포장 피드백</a>
                    <i class="fas fa-chevron-right"></i>
                </li>
            </ul>
        </div>
        
        <!-- leftSide chatbot? 1:1 문의하기 -->
        <div>
            <a href="${pageContext.request.contextPath}/cs/notice" id="leftSide-inquire"><span class="">도움이 필요하신가요?</span>1:1 문의하기</a><i class="fa-solid fa-angle-right"></i>
        </div>
    </div>
    
    <!-- insert section -->
    <div class="page-section">
        <h2 class="insert-title">1:1문의</h2>
        <div class="board-write">
            <form action="">
                <table class="">
                    <colgroup>
                        
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>제목</th>
                            <td>
                                <select name="" id="">
                                    <option value="">선택해주세요.</option>
                                    <option value="">배송지연/불만</option>
                                    <option value="">컬리패스 (무료배송)</option>
                                    <option value="">반품문의</option>
                                    <option value="">A/S문의</option>
                                    <option value="">환불문의</option>
                                    <option value="">주문결제문의</option>
                                    <option value="">회원정보문의</option>
                                    <option value="">취소문의</option>
                                    <option value="">교환문의</option>
                                    <option value="">상품정보문의</option>
                                    <option value="">기타문의</option>
                                </select>
                                <br>
                                <input type="text">
                            </td>
                        </tr>
                        <tr>
                            <th>주문번호</th>
                            <td>
                                <input type="text">
                                <button class="board-submitBtn">주문번호</button>
                            </td>
                        </tr>
                        <tr>
                            <th>이메일</th>
                            <td>
                                <input type="text" name="email" value="email">
                                <label for="agree-checkbox">
                                    <input type="checkbox" id="agree-checkbox">
                                    답변수신을 이메일로 받겠습니다.
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>문자메세지</th>
                            <td>
                                <input type="text" name="sms" value="sms">
                                <label for="agree-checkbox">
                                    <input type="checkbox" id="agree-checkbox">
                                    답변수신을 문자로 받겠습니다.
                                </label>
                            </td>
                        </tr>
                        <tr>
                            <th>내용</th>
                            <td>
                                <strong>1:1 문의 작성 전 확인해주세요!</strong>

                                <dl>
                                    <strong>반품 / 환불</strong>
                                    <dt>제품 하자 혹은 이상으로 반품(환불)이 필요한 경우 사진과 함께 구체적인 내용을 남겨주세요.</dt>
                                </dl>

                                <dl>
                                    
                                    <strong>주문취소</strong>
                                    <dt>주문취소는 배송 단계별로 방법이 상이합니다.</dt>
                                    <dd>[배송준비중] 이전까지 주문 취소 가능합니다.</dd>
                                    <dd>[마이컬리 > 주문내역 상세페이지]에서 직접 취소하실 수 있습니다.</dd>
                                </dl>
                                <dl>
                                    <dt>[배송준비중] 부터는 취소가 불가하니, 반품으로 진행해주세요. (상품에 따라 반품이 불가할 수 있습니다.)</dt>
                                    <dt>비회원은 모바일 App 또는 모바일 웹사이트에서 [마이컬리 > 비회원 주문 조회 페이지] 에서 취소가 가능합니다.</dt>
                                    <dt>일부 예약상품은 배송 3~4일 전에만 취소 가능합니다.</dt>
                                    <dt>주문상품의 부분 취소는 불가능합니다. 전체 주문 취소 후 재구매 해주세요.</dt>
                                </dl>
                                <dl>
                                    <strong>배송</strong>
                                    <dt>주문 완료 후 배송 방법(샛별 / 택배)은 변경이 불가능합니다.</dt>
                                    <dt>배송일 및 배송시간 지정은 불가능합니다. (예약배송 포함)</dt>
                                    <span>&#8251;전화번호, 이메일, 주소, 계좌번호 등의 상세 개인정보가 문의 내용에 저장되지 않도록 주의해 주시기 바랍니다.</span>
                                </dl>
                                <textarea name="content" id="write-textarea" cols="30" rows="10"></textarea>
                                </td>
                        </tr>
                        <tr>
                            <th>이미지</th>
                            <td>
                                <table class="upload-table">
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>
                                                <input type="file">
                                                <a href=""><i class="fas fa-plus"></i><span>업로드추가</span></a>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <dl>
                                    <dt>파일은 최대 5개까지 업로드가 지원됩니다.</dt>
                                </dl>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <button class="board-submitBtn" name="" value="">저장</button>
            </form>
        </div> 


    </div>
       
    <!-- cs page 끝 -->
    </div>

  <i class="fas fa-minus"></i>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>